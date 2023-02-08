//
//  Constant.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 5/2/23.
//

import Foundation
class constant {
    static var isVerify: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isVerify")
        } get {
            var user_value = false
            if UserDefaults.standard.value(forKey: "isVerify") != nil {
                user_value = UserDefaults.standard.value(forKey: "isVerify") as! Bool
            }
            return user_value
        }
    }
}
