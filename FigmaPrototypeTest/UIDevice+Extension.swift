//
//  UIDevice+Extension.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 11/2/23.
//

import UIKit
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
