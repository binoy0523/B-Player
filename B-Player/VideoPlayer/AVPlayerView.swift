//
//  AVPlayerView.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import UIKit
import AVFoundation
class AVPlayerView: UIView {
    
    
    override class var layerClass: AnyClass {
           return AVPlayerLayer.self
       }

    fileprivate var avPlayerLayer: AVPlayerLayer {
            return layer as! AVPlayerLayer
        }


      
}
