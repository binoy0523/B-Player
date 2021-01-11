//
//  VideoModelProtocol.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation
import AVKit
protocol VideoModelProtocol {
    
    var videoUrl:URL? { get set }
    
    var avPlayerItem:AVPlayerItem? { get set }
    
    var duration :CMTime? {get set} //total time
    
    var currentTime:CMTime? {get set}
    

}
