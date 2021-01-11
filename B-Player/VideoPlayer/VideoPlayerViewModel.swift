//
//  VideoPlayerViewModel.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation
import AVKit
class VideoPlayerViewModel: VideoPlayerViewModelProtocol {
    
    var detailModel: VideoDetailViewModelProtocol?
    
    weak var viewDelegate: VideoPlayerViewProtocol?
    
    var model: VideoModelProtocol?
    
  

    init(model:VideoModelProtocol? = nil, detailModel: VideoDetailViewModelProtocol? = nil, viewDelegate:VideoPlayerViewProtocol? = nil) {
        self.model = model
        self.viewDelegate = viewDelegate
        self.detailModel = detailModel
        self.setSlidervalue()
    }
    
    var playerItem: AVPlayerItem? {
        return model?.avPlayerItem
    }
    
    
    var videoDuration: String? {
        return model?.duration?.positionalTime
    }
    
    var currentPlayingTime : CMTime? {
        return self.model?.currentTime
    }
    func setSlidervalue() {
        guard let playerItem = model?.avPlayerItem else { return }
        let duration = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        DispatchQueue.main.async {
            self.viewDelegate?.setSliderValue(value: Float(seconds))
        }
        
    }
    
    func didFinishedPlayingCurrentItem() {
        
        
    }
    
    func findDuration() {
        
    }
    
    func setCurrentPlayingTime(time: Float) {
        if let playingTime = self.model?.duration?.roundedSeconds, Float(playingTime) == time {
            self.detailModel?.updateVideoInLocalWith(currentTime: 0)
        } else {
            self.detailModel?.updateVideoInLocalWith(currentTime: time)
        }
       
        
    }
}
