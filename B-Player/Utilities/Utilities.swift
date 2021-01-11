//
//  Utilities.swift
//  B-Player
//
//  Created by user on 11/01/21.
//

import Foundation

class Utilities {
    
    static func getPositionalTimeFrom(seconds:Float)-> String {
        
        var hours:  Int { return Int(seconds / 3600) }
        var minute: Int { return Int(seconds.truncatingRemainder(dividingBy: 3600) / 60) }
        var second: Int { return Int(seconds.truncatingRemainder(dividingBy: 60)) }
        var positionalTime: String {
            return hours > 0 ?
                String(format: "%d:%02d:%02d",
                       hours, minute, second) :
                String(format: "%02d:%02d",
                       minute, second)
        }
        
        return positionalTime
    }
}
