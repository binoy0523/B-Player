//
//  VideoPlayer.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import UIKit
import AVFoundation
import CoreMedia


protocol VideoPlayerDelegate : AnyObject{
    func toggleFullScreen(isFullScreen:Bool)
    func didFinishedPlayingCurrentItem()
}

class VideoPlayer: UIView,VideoPlayerViewProtocol {
    
    @IBOutlet weak var overLay: UIView!
    
    @IBOutlet weak var vPlayer: AVPlayerView!
    
    @IBOutlet weak var labelOverallDuration: UILabel!
    
    @IBOutlet weak var labelCurrentTime: UILabel!
    
    @IBOutlet weak var playbackSlider: UISlider!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var ButtonPlay: UIButton!
    
    var player: AVQueuePlayer?
    
    fileprivate var hasGoneFullScreen = false
    
    fileprivate var isFullScreen = false
    
    fileprivate var originalFrame = CGRect.zero
    
    var timeObserverToken: Any?
    
    var viewModel:VideoPlayerViewModelProtocol?
    
    weak var delegate : VideoPlayerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        uiInit()
    }
    
    
    /**
     * Initialising Xib for video player view
     */
    fileprivate func uiInit() {
        let viewFromXib = Bundle.main.loadNibNamed("VideoPlayer", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addPlayerToView(self.vPlayer)
        addSubview(viewFromXib)
    }
    
    /**
     * Adding  AVPlayerLayer to desired view
     */
    fileprivate func addPlayerToView(_ view: UIView) {
        player = AVQueuePlayer()
        let castedLayer = vPlayer.layer as! AVPlayerLayer
        castedLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        castedLayer.player = player
        addPeriodicTimeObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
//    MARK:- SetUp ViewModel
    func setViewModel(withModel model:VideoModelProtocol, detailModel:VideoDetailViewModelProtocol?) {
        viewModel = VideoPlayerViewModel(model: model,detailModel: detailModel ,viewDelegate: self)
    }
    
    
//    MARK:- Toggle fullscren mode
    private func togglePlayback() {
        if !hasGoneFullScreen {
            originalFrame = frame
            hasGoneFullScreen = true
        }
        
        isFullScreen = !isFullScreen
        if isFullScreen {
            self.goFullscreen()
            
        } else {
            
            self.minimizeToFrame(originalFrame)
        }
    }
    
    
    //    Periodic Time Observer for video
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: time,
                                                            queue: .main) {
            [weak self] time in
            // update player transport UI
            self?.viewModel?.setCurrentPlayingTime(time: Float(time.roundedSeconds))
            self?.setCurrentTime(time: time.positionalTime)
            self?.updateSlider(val: Float(CMTimeGetSeconds(time)))
            
        }
    }
    
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
//    MARK:- AVPlayer finished playiing Observer
    @objc func playerDidFinishPlaying() {
        self.delegate?.didFinishedPlayingCurrentItem()
//        ButtonPlay.isSelected = false
        
    }
    
    
    
    
    //    MARK:- Slider Action (Seeking video)
    @IBAction func sliderMoved(_ sender: UISlider, forEvent event: UIEvent) {
        
        let touch = event.allTouches?.first
        switch touch!.phase {
        case UITouch.Phase.began:
            removePeriodicTimeObserver()
        case UITouch.Phase.ended:
            addPeriodicTimeObserver()
        default:
            break
        }
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player?.seek(to: targetTime)
        self.setCurrentTime(time: Utilities.getPositionalTimeFrom(seconds: playbackSlider.value))
        
    }
    
//    MARK:- Toggle fullscreen action
    @IBAction func toggleFullScreen(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.translatesAutoresizingMaskIntoConstraints = true
        self.togglePlayback()
        self.delegate?.toggleFullScreen(isFullScreen: isFullScreen)
    }
    
    
//    MARK:- Play/Pause action
    @IBAction func playPauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            self.playVideo()
        } else {
            self.pauseVideo()
        }
        
    }
    
    
    // View Protocols
    func initVideo() {
        DispatchQueue.main.async(execute: {[weak self] () in
            self?.labelOverallDuration.text = self?.viewModel?.videoDuration
            let playerItem = self?.viewModel?.playerItem
            self?.player?.replaceCurrentItem(with: playerItem)
            guard  let currentTime = self?.viewModel?.currentPlayingTime else { return }
            self?.player?.seek(to: currentTime)
        })
        
    }
    
    func playVideo() {
        if player?.currentItem?.currentTime() == player?.currentItem?.duration {
            player?.seek(to: CMTime.zero)
            player?.play()
        } else {
            player?.play()
        }
        
    }
    
    func setSliderValue(value: Float) {
        playbackSlider.minimumValue = 0
        playbackSlider.maximumValue =  value
    }
    func pauseVideo() {
        player?.pause()
    }
    
    func setTotalDuration(duration: String) {
        labelOverallDuration.text = duration
    }
    
    func setCurrentTime(time: String) {
        labelCurrentTime.text = time
        
    }
    
    func updateSlider(val:Float) {
        playbackSlider.setValue(val, animated: true)
    }
}
