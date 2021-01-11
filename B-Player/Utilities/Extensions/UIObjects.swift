//
//  UIObjects.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import Foundation
import UIKit
import AVKit
//@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
      }
}


extension CGAffineTransform {

    static let ninetyDegreeRotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
}

extension UIView {

    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }

    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.layer.setAffineTransform(.identity)
            self.frame = frame
        }
    }

    func goFullscreen() {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.layer.setAffineTransform(.ninetyDegreeRotation)
            guard  let window = UIApplication.shared.windows.first else { return }
            let topPadding = window.safeAreaInsets.top
            let bottomPadding = window.safeAreaInsets.bottom
            self.frame = CGRect(x: 0, y: topPadding, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - topPadding)
        }
    }
}
