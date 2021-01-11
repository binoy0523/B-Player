//
//  VideoViewModel.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation
protocol VideoViewModelProtocol {
    
    var title: String? { get }
    
    var thumbnail : String? { get }
    
    var videoDescription : String? { get}
    
    var url: String? { get }
    
    var video : Video? { get set }
}
class VideoViewModel:VideoViewModelProtocol {
    var title: String? {
        return video?.title ?? ""
    }
    
    var thumbnail: String? {
        return video?.thumbnail ?? ""
    }
    
    var videoDescription: String? {
        return video?.vdescription ?? ""
    }
    
    var url: String? {
        return video?.url  ?? ""
    }
    
    var video:Video?
    
    init(video:Video) {
        self.video = video
    }
    
}
