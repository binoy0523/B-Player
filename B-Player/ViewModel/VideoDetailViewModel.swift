//
//  VideoDetailViewModel.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation
protocol VideoDetailViewModelProtocol {
    
    var model : VideoDetailModelProtocol? {get set}
    
    var viewDelegate : VideoDetailViewProtocol? { get set}
    
    var selectedVideo : Video? {get}
    
    var relatedVideos : [Video]? {get}
    
    var numberOfRelatedVideos : Int? {get}
    
    var videoTitle:String? { get }
    
    var videoDescription:String? { get }
    
    func updateVideoInLocalWith(currentTime time:Float)
    
    func videoViewModelFor(index:Int) -> VideoViewModelProtocol?
    
    func didSelectRelatedVideo(atIndex index:Int)
}

class VideoDetailViewModel : VideoDetailViewModelProtocol {
   
    
    var model: VideoDetailModelProtocol?
    
    weak var viewDelegate: VideoDetailViewProtocol?
    
    var selectedVideo: Video? {
        return model?.selectedVideo
    }
    
    var relatedVideos: [Video]? {
        return model?.relatedVideos
    }
    var numberOfRelatedVideos: Int? {
        return relatedVideos?.count
    }
    var videoTitle: String? {
        return self.selectedVideo?.title
    }
    
    var videoDescription: String? {
        return self.selectedVideo?.vdescription
    }
    
    init(withViewDelegate viewDelegate: VideoDetailViewProtocol? = nil, withModel model:VideoDetailModelProtocol?) {
        self.model = model
        self.viewDelegate = viewDelegate
        self.viewDelegate?.reload()
        
    }
    
    func updateVideoInLocalWith(currentTime time: Float) {
        self.model?.updateVideoTime(time: time)
    }
    
    func videoViewModelFor(index:Int) -> VideoViewModelProtocol? {
        guard let video = self.relatedVideos?[index] else {
         return nil
        }
        
        let viewModel = VideoViewModel(video:video)
        return viewModel
    }
    
    func didSelectRelatedVideo(atIndex index: Int) {
       
        guard let relatedVideos = self.model?.relatedVideos,  let existingVideo = self.model?.selectedVideo else { return }
        let newSelectedVideo = relatedVideos[index]
        self.model?.selectedVideo = newSelectedVideo
        self.model?.relatedVideos = relatedVideos.filter({ $0.id != newSelectedVideo.id})
        self.model?.relatedVideos?.append(existingVideo)
        self.viewDelegate?.didUpdatedVideo()
        
    }
    
    
}
