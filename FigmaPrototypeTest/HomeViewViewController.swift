//
//  HomeViewViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 31/1/23.
//

import UIKit
import THPDFKit
import CocoaLumberjack
import Speech
import NotificationToast
import Reachability
import Network

class HomeViewViewController: UIViewController{
    
    
    @IBOutlet weak var viewDeckBtn: TransitionButton!
    @IBOutlet weak var backShadowView4: UIView!
    @IBOutlet weak var backShadowView3: UIView!
    @IBOutlet weak var backShadowView2: UIView!
    @IBOutlet weak var backShadowView: UIView!
    
    @IBOutlet weak var meetTeamImg: UIImageView!
    @IBOutlet weak var pdfImg: UIImageView!
    @IBOutlet weak var prototypeImg: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    
    @IBOutlet weak var meetTeamView: UIView!
    @IBOutlet weak var pdfBackView: UIView!
    @IBOutlet weak var prototypeView: UIView!
    @IBOutlet weak var videoView: UIView!
    
    let reachability = try! Reachability()
    var isNetworkAvailable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shadowViews = [backShadowView, backShadowView2, backShadowView3, backShadowView4]
            let shadowImages = [pdfImg, prototypeImg, videoImg, meetTeamImg]
            let cornerRadius: CGFloat = 8
            let shadowRadius: CGFloat = 2
            let shadowOffset = CGSize(width: 1, height: 2)
            let shadowColor = UIColor.black.cgColor
            
            for shadowView in shadowViews {
                shadowView!.layer.cornerRadius = cornerRadius
                shadowView!.layer.shadowOffset = shadowOffset
                shadowView!.layer.shadowRadius = shadowRadius
                shadowView!.layer.shadowColor = shadowColor
            }
            
            for shadowImage in shadowImages {
                shadowImage!.layer.cornerRadius = cornerRadius
                shadowImage!.layer.masksToBounds = true
                shadowImage!.clipsToBounds = true
            }
        
        startReachability()
    }
    
    func startReachability() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            isNetworkAvailable = true
        case .cellular:
            isNetworkAvailable = true
            print("Reachable via Cellular")
        case .unavailable:
            isNetworkAvailable = false
            print("Network not reachable")
        case .none:
            print("skdslkd")
        }
        
    }
    
    @IBAction func introductionVideo(_ sender: Any) {
        
        showToastSuccess(message: "Introduction video will be available soon!")
        
    }
    
    func checkNetwork() -> Bool {
        //        if #available(iOS 12.0, *) {
        //            let networkCheck = NetworkCheck.sharedInstance()
        //            if networkCheck.currentStatus == .satisfied{
        //                            //Do something
        ////                return true
        //                        }else{
        //                            //Show no network alert
        ////                            return false
        //                        }
        //            networkCheck.addObserver(observer: self)
        //        } else {
        //            // Fallback on earlier versions
        //            return false
        //        }
        
        return isNetworkAvailable
    }
    
    fileprivate func goPrototype() {
        if checkNetwork() {
            DispatchQueue.main.async {
                self.navigationController?.navigationBar.isHidden = false
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        } else {
            showToast(message: "No internet connection.")
        }
    }
    
    @IBAction func seePrototype(_ sender: Any) {
        let isVerified = constant.isVerify
        guard isVerified else {
            openAlert(isPrototype: "Prototype")
            return
        }
        goPrototype()
    }
    
    func openAlert(isPrototype: String) {
        
        let alertController = UIAlertController (title: "Hello there!", message: "Please enter the code that you have got from Baller Academy", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let firstTextField = alertController.textFields![0] as UITextField
    
            guard let code = firstTextField.text, !code.isEmpty else {
                self.showToast(message: "Insert 6-digit code")
                return
            }
            guard firstTextField.text?.count == 6 else {
                self.showToast(message: "Insert 6-digit code")
                return
            }
            if self.checkNetwork() {
                self.apiCall(isPrototype: isPrototype, otpText: code)
            }else {
                self.showToast(message: "Connection: error.")
            }
            
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func handleDeck() {
        
        do {
            try self.goDeckVC()
        } catch _ {
            self.showToast(message: "Something went wrong. Please try again")
        }
        
    }
    
    func showToastSuccess(message: String) {
        
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let toast = ToastViewL(
                    title: message,
                    titleFont: .systemFont(ofSize: 13, weight: .regular),
                    subtitleFont: .systemFont(ofSize: 11, weight: .light),
                    backgroundColorView: .systemGreen, iconSpacing: 16,
                    position: .bottom,
                    onTap: { print("Tapped!") }
                )
                toast.show()
            } else {
                // Fallback on earlier versions
                let toast = ToastViewL(
                    title: message,
                    titleFont: .systemFont(ofSize: 13, weight: .regular),
                    subtitleFont: .systemFont(ofSize: 11, weight: .light),
                    backgroundColorView: .systemGreen, iconSpacing: 16,
                    position: .bottom,
                    onTap: { print("Tapped!") }
                )
                toast.show()
            }
        }
        
    }
    
    
    func apiCall(isPrototype: String, otpText: String) {
        
        let urlString = "https://messagealarm.app/api/otp_check/"
        guard let url = URL(string: urlString) else { return }
        
        let parameters = [
            "otp": otpText
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            self.showToast(message: "Error creating request body")
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.showToast(message: "Connection error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode,
                let data = data else {
                    self.showToast(message: "Please try again.")
                    return
            }
            
            do {
                let products = try JSONDecoder().decode(otpVerModel.self, from: data)
                if products.success {
                    self.showToastSuccess(message: "Thanks for verifying, You can now see everything")
                    constant.isVerify = true
                    switch isPrototype {
                    case "Prototype":
                        self.goPrototype()
                    case "Deck":
                        self.handleDeck()
                    case "meetTeam":
                        self.goMeetTheTeamVC()
                    default:
                        self.goScheduleVC()
                    }
                } else {
                    self.showToast(message: "This code is either invalid or expired or already used!")
                }
            } catch {
                self.showToast(message: "This code is either invalid or expired or already used!")
            }
        }.resume()
    }

    
    func showToast(message: String) {
        
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let toast = ToastViewL(
                    title: "Failure",
                    titleFont: .systemFont(ofSize: 13, weight: .regular),
                    subtitle: message,
                    subtitleFont: .systemFont(ofSize: 11, weight: .light),
                    iconSpacing: 16,
                    position: .bottom,
                    onTap: { print("Tapped!") }
                )
                toast.show()
            } else {
                // Fallback on earlier versions
                let toast = ToastViewL(
                    title: "Failure",
                    titleFont: .systemFont(ofSize: 13, weight: .regular),
                    subtitle: message,
                    subtitleFont: .systemFont(ofSize: 11, weight: .light),
                    iconSpacing: 16,
                    position: .bottom,
                    onTap: { print("Tapped!") }
                )
                toast.show()
            }
        }
        
    }
    
    @IBAction func meetTeamAciton(_ sender: Any) {
        
        if constant.isVerify {
            goMeetTheTeamVC()
        }else {
            openAlert(isPrototype: "meetTeam")
        }
        
        
    }
    func goMeetTheTeamVC() {
        
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    fileprivate func goDeckVC() throws {
        
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    @IBAction func seePdfAction(_ sender: Any) {
        
        if constant.isVerify {
            self.handleDeck()
        }else {
            openAlert(isPrototype: "Deck")
        }
        
    }
    
    @IBAction func seeScheduleAction(_ sender: Any) {
        
        if constant.isVerify {
            self.goScheduleVC()
        }else {
            openAlert(isPrototype: "schedule")
        }
        
    }
    
    func goScheduleVC() {
        
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}


extension UIImageView {
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

struct otpVerModel: Codable {
    
    let success : Bool
    
}

