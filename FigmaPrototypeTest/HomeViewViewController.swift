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

class HomeViewViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backShadowView.layer.cornerRadius = 8
        backShadowView2.layer.cornerRadius = 8
        backShadowView3.layer.cornerRadius = 8
        backShadowView4.layer.cornerRadius = 8
        
        prototypeView.layer.cornerRadius = 8
        prototypeView.layer.shadowOffset = CGSize(width: 1, height: 2)
        prototypeView.layer.shadowRadius = 2
        prototypeView.layer.shadowColor = UIColor.black.cgColor
        
        videoView.layer.cornerRadius = 8
        videoView.layer.shadowOffset = CGSize(width: 1, height: 2)
        videoView.layer.shadowRadius = 2
        videoView.layer.shadowColor = UIColor.black.cgColor
        
        pdfBackView.layer.cornerRadius = 8
        pdfBackView.layer.shadowOffset = CGSize(width: 1, height: 2)
        pdfBackView.layer.shadowRadius = 2
        pdfBackView.layer.shadowColor = UIColor.black.cgColor
        
        meetTeamView.layer.cornerRadius = 8
        meetTeamView.layer.shadowOffset = CGSize(width: 1, height: 2)
        meetTeamView.layer.shadowRadius = 2
        meetTeamView.layer.shadowColor = UIColor.black.cgColor
        
        pdfImg.layer.cornerRadius = 8
        prototypeImg.layer.cornerRadius = 8
        videoImg.layer.cornerRadius = 8
        meetTeamImg.layer.cornerRadius = 8
        
        self.pdfImg.layer.masksToBounds = true
        self.pdfImg.clipsToBounds = true
        
        SwiftyTranslate.translate(text: "my name is sohel", from: "en", to: "bn") { result in
            switch result {
                case .success(let translation):
                    print("Translated: \(translation.translated)")
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
        
    }
    
    func checkNetwork() -> Bool {
        if #available(iOS 12.0, *) {
            let networkCheck = NetworkCheck.sharedInstance()
            if networkCheck.currentStatus == .satisfied{
                            //Do something
                return true
                        }else{
                            //Show no network alert
                            return false
                        }
        } else {
            // Fallback on earlier versions
            
        }
        return false
    }
    
    fileprivate func goPrototype() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func seePrototype(_ sender: Any) {
        if constant.isVerify {
            goPrototype()
        }else {
            openAlert(isPrototype: true)
        }
        
    }
    
    func openAlert(isPrototype: Bool) {
        let alertController = UIAlertController (title: "Verify Yourself", message: "Enter the code that you have got from Baller Academy", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Your Code"
            }
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let firstTextField = alertController.textFields![0] as UITextField
            
            guard firstTextField.text != nil else {
                self.showToast(message: "Code is empty.")
                return
            }
            
            guard firstTextField.text != "" else {
                self.showToast(message: "Code is empty.")
                return
            }
            guard firstTextField.text?.count == 6 else {
                self.showToast(message: "Enter the valid code.")
                return
            }
            if self.checkNetwork() {
            self.apiCall(isPrototype: isPrototype, otpText: firstTextField.text!)
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
            self.showToast(message: "Something went wrong, Try again!")
        }
    }
    
    func apiCall(isPrototype:Bool, otpText: String) {
        let Url = String(format: "https://messagealarm.app/api/otp_check/")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                "otp": otpText
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard data != nil else {
                    self.showToast(message: "Connection: error.")
                    return
                }
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    self.showToast(message: "Please try again.")
                    return
                }
                
                do {
                    let products = try JSONDecoder().decode(otpVerModel.self, from: data!)
                    print(products)
                    if products.success {
                        constant.isVerify = true
                        if isPrototype {
                            self.goPrototype()
                        }else {
                            self.handleDeck()
                        }
                    }else {
                        self.showToast(message: "This code is either invalid or expired or already used!")
                    }
                }catch {
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
    func userAutorization(){
      SFSpeechRecognizer.requestAuthorization { (authStatus) in
        var isButtonEnabled = false
        switch authStatus {
        case .authorized:
          isButtonEnabled = true
            
            
        case .denied:
          isButtonEnabled = false
          print("User denied access to speech recognition")
            DispatchQueue.main.async {
            self.openSetting()
            }
        case .restricted:
          isButtonEnabled = false
          print("Speech recognition restricted on this device")
        case .notDetermined:
          isButtonEnabled = false
          print("Speech recognition not yet authorized")
        }
      }
    }
    
    func openSetting() {
        let alertController = UIAlertController (title: "Speech recognition will be used to determine which words you speak into this device's microphone.", message: "Go to Settings?", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func meetTeamAciton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    fileprivate func goDeckVC() throws {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController
            self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func seePdfAction(_ sender: Any) {
        if constant.isVerify {
            self.handleDeck()
        }else {
            openAlert(isPrototype: false)
        }
        
    }
    
    @IBAction func seeScheduleAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
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
