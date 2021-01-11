//
//  VideoModel.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation
import AVKit

class VideoModel: VideoModelProtocol {

    var avPlayerItem: AVPlayerItem?
    
    var currentTime: CMTime?
    
    var videoUrl: URL?
    
    var duration: CMTime?
    
    init(url:URL, currentTime:Float) {
        self.videoUrl = url
        self.avPlayerItem = AVPlayerItem(url: url)
        self.currentTime = CMTimeMake(value: Int64(currentTime), timescale: 1)
        duration = self.avPlayerItem?.asset.duration
        
    }
    
    
    
}
