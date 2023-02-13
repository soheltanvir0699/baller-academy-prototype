//
//  DisclaimerAlert.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 13/2/23.
//

import Foundation
import UIKit


class DisclaimerAlert: UIView {
    
    @IBOutlet weak var iconBtn: UIImageView!
    @IBOutlet weak var submitAction: TransitionButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconBtn.layer.borderColor = UIColor.white.cgColor
        iconBtn.layer.borderWidth = 5
    }

}
