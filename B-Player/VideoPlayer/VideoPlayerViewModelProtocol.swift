//
//  VideoPlayerViewModelProtocol.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation
import AVKit
protocol  VideoPlayerViewModelProtocol{
    
    var viewDelegate: VideoPlayerViewProtocol? { get set}
    
    var model:VideoModelProtocol? { get set}
    
    var detailModel : VideoDetailViewModelProtocol? { get }
    
    var currentPlayingTime : CMTime? { get }
    
    var playerItem:AVPlayerItem? { get }
    
    var videoDuration:String? { get }
    
    func didFinishedPlayingCurrentItem()
    
    func setSlidervalue()
    
    func setCurrentPlayingTime(time:Float)
    
    
}
