//
//  VideoPlayerViewProtocol.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation

protocol VideoPlayerViewProtocol:class {
    
    func initVideo()
    
    func playVideo()
    
    func pauseVideo()
    
    func setTotalDuration(duration:String)
    
    func setCurrentTime(time:String)
    
    func setSliderValue(value:Float)
    
   
    
}
