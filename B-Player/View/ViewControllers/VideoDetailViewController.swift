//
//  ViewController.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import UIKit

class VideoDetailViewController: UIViewController, VideoDetailViewProtocol, VideoPlayerDelegate {
    
    @IBOutlet weak var playerView: VideoPlayer!
    var viewModel:VideoDetailViewModelProtocol?
    @IBOutlet weak var relatedTableView: UITableView!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.playerView.delegate = self
        self.setVideoPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //    MARK:- SetUp Video player
    private func setVideoPlayer() {
        self.title = self.viewModel?.videoTitle
        self.videoTitle.text = self.viewModel?.videoTitle
        self.videoDescription.text = self.viewModel?.videoDescription
        DispatchQueue.global(qos: .userInitiated).async(execute:{ [weak self] () in
            guard let selectedVideoUrl = self?.viewModel?.selectedVideo?.url, let vUrl = URL(string:selectedVideoUrl), let currentTime = self?.viewModel?.selectedVideo?.currentTime else { return}
            let model = VideoModel(url:vUrl,currentTime: currentTime)
            self?.playerView.setViewModel(withModel: model, detailModel:self?.viewModel)
            self?.playerView.initVideo()
        })
        
    }
    
    
    //    MARK:- VideoPlayer Delegate
    func reload() {
        self.relatedTableView?.reloadData()
    }
    
    func didUpdatedVideo() {
        self.setVideoPlayer()
        self.reload()
    }
    
    func toggleFullScreen(isFullScreen: Bool) {
        if isFullScreen {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func didFinishedPlayingCurrentItem() {
        self.viewModel?.didSelectRelatedVideo(atIndex: 0)
    }
}

extension VideoDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRelatedVideos ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath)
        // Configure the cell...
        if let cell = cell as? VideoTableViewCell, let videoViewModel = self.viewModel?.videoViewModelFor(index: indexPath.row) {
            cell.setVideoList(for: videoViewModel)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectRelatedVideo(atIndex: indexPath.row)
    }
}
