//
//  Constant.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 5/2/23.
//

import Foundation
class constant {
    static var defaultProtypeLink = "https://www.figma.com/proto/9af6kpJB18dEZGcRmcX18G/Prototype-Test?node-id=2309%3A20362&scaling=min-zoom&page-id=22%3A5297&starting-point-node-id=618%3A12289"
    static var defaultDeckLink = "https://baller-ac.s3.amazonaws.com/deck.pdf"
    static var rotationType = ""
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
    
    static var isGeneric: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isGeneric")
        } get {
            var user_value = false
            if UserDefaults.standard.value(forKey: "isGeneric") != nil {
                user_value = UserDefaults.standard.value(forKey: "isGeneric") as! Bool
            }
            return user_value
        }
    }
    
    static var OtpRespose: [String] {
        set {
            UserDefaults.standard.set(newValue, forKey: "OtpRespose")
        } get {
            var user_value = [String]()
            if UserDefaults.standard.value(forKey: "OtpRespose") != nil {
                user_value = UserDefaults.standard.value(forKey: "OtpRespose") as! [String]
            }
            return user_value
        }
    }
    
    static var tester_name: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "tester_name")
        } get {
            var user_value = ""
            if UserDefaults.standard.value(forKey: "tester_name") != nil {
                user_value = UserDefaults.standard.value(forKey: "tester_name") as! String
            }
            return user_value
        }
    }
}
