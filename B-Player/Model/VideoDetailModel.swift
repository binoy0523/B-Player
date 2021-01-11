//
//  VideoDetailModel.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation
protocol VideoDetailModelProtocol {
    
    var selectedVideo : Video? { get set }
    
    var relatedVideos : [Video]? { get set }
    
    func updateVideoTime(time:Float)
    
}


class VideoDetailModel : VideoDetailModelProtocol {
   
    
    var selectedVideo: Video?
    var relatedVideos: [Video]?
    
    init(withSelectedVideo selectedvideo:Video?, relatedVideos: [Video]?) {
        self.selectedVideo = selectedvideo
        self.relatedVideos = relatedVideos
    }
    
    
    func updateVideoTime(time:Float) {
        selectedVideo?.currentTime = time
        VideoLocalDBManager.sharedManager.saveChanges()
    }
    
}
