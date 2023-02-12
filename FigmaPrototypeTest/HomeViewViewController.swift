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
    @IBOutlet weak var techTopCons: NSLayoutConstraint!
    
    @IBOutlet weak var introductionLbl: UILabel!
    @IBOutlet weak var techHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewDeckBtn: TransitionButton!
    @IBOutlet weak var backShadowView4: UIView!
    @IBOutlet weak var backShadowView3: UIView!
    @IBOutlet weak var backShadowView2: UIView!
    @IBOutlet weak var backShadowView: UIView!
    @IBOutlet weak var backShadowView5: UIView!
    
    @IBOutlet weak var meetTeamImg: UIImageView!
    @IBOutlet weak var pdfImg: UIImageView!
    @IBOutlet weak var prototypeImg: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    
    @IBOutlet weak var techView: UIView!
    @IBOutlet weak var meetTeamView: UIView!
    @IBOutlet weak var pdfBackView: UIView!
    @IBOutlet weak var prototypeView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var technicalImg: UIImageView!
    
    let reachability = try! Reachability()
    var isNetworkAvailable = false
    let rootView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)?[0] as? AlertView

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shadowViews = [backShadowView, backShadowView2, backShadowView3, backShadowView4,backShadowView5]
            let shadowImages = [pdfImg, prototypeImg, videoImg, meetTeamImg,technicalImg]
            let cornerRadius: CGFloat = 4
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
    
    func techShowHide() {
        if constant.tester_name == "Alexis Sr." {
            techPdfShowHide(isShow: true)
        }else {
            techPdfShowHide(isShow: false)
        }
    }
    
    func techPdfShowHide(isShow: Bool) {
        DispatchQueue.main.async {
            if isShow {
                self.techView.isHidden = false
                self.techTopCons.constant = 15
                self.techHeight.constant = 300
            }else {
                self.techTopCons.constant = 0
                self.techHeight.constant = 0
                self.techView.isHidden = true
            }
        }
        
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
        return isNetworkAvailable
    }
    
    fileprivate func goPrototype(data: [String]?) {
        if checkNetwork() {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
                if data != nil && data!.count >= 1{
                    if data![0] != "" {
                        vc?.prototypeLink = data![0]
                        print(data)
                    }
                }
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController?.pushViewController(vc!, animated: true)
            })
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
        goPrototype(data: constant.OtpRespose)
    }
    
    var prototypeText = ""
    func openAlert(isPrototype: String) {
        prototypeText = isPrototype
        rootView?.dissmissBtn.addTarget(self, action: #selector(dismissSupView), for: .touchUpInside)
        rootView?.submitAction.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        if let aView = rootView {
            aView.tag = 100
            self.navigationController?.view.addSubview(aView)
            guard let navView = self.navigationController?.view else {return}
            navView.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
            aView.topAnchor.constraint(equalTo: navView.topAnchor, constant: 0).isActive = true
            aView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
            aView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 0).isActive = true
            aView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: 0).isActive = true
            
        }
        
//        let alertController = UIAlertController (title: "Hello there!", message: "Please enter the code that you have got from Baller Academy", preferredStyle: .alert)
//        alertController.addTextField { (textField : UITextField!) -> Void in
//        }
//        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//            let firstTextField = alertController.textFields![0] as UITextField
//
//            guard let code = firstTextField.text, !code.isEmpty else {
//                self.showToast(message: "Insert 6-digit code")
//                return
//            }
//            guard firstTextField.text?.count == 6 else {
//                self.showToast(message: "Insert 6-digit code")
//                return
//            }
//            if self.checkNetwork() {
//                self.apiCall(isPrototype: isPrototype, otpText: code)
//            }else {
//                self.showToast(message: "Connection: error.")
//            }
//
//        }))
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//        alertController.addAction(cancelAction)
//
//        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func submitAction() {
        guard let code = rootView?.textFld.text, !code.isEmpty else {
                        self.showToast(message: "Insert 6-digit code")
                        return
                    }
        guard rootView?.textFld.text?.count == 6 else {
                        self.showToast(message: "Insert 6-digit code")
                        return
                    }
                    if self.checkNetwork() {
                        DispatchQueue.main.async {
                            self.rootView?.submitAction.startAnimation()
                        }
                        self.apiCall(isPrototype: prototypeText, otpText: code)
                    }else {
                        self.showToast(message: "Connection: error.")
                    }
    }
    
    @objc func dismissSupView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            
            for subview in (self.navigationController?.view.subviews)! {
                if (subview.tag == 100) {

                    subview.removeFromSuperview()
                }
            }
        }
        
        
    }
    
    fileprivate func handleDeck(data: [String]?) {
        
        do {
            try self.goDeckVC(data: data)
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
            DispatchQueue.main.async {
                self.rootView?.submitAction.stopAnimation()
            }
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
                    self.dismissSupView()
                    self.showToastSuccess(message: "Thanks for verifying, You can now see everything")
                    constant.isVerify = true
                    var responseArray = [String]()
                    if products.prototype_url != nil {
                        responseArray.append(products.prototype_url!)
                    }
                    if products.deck_url != nil {
                        responseArray.append(products.deck_url!)
                    }
                    constant.tester_name = products.tester_name!
                    self.techShowHide()
                    constant.OtpRespose = responseArray
                    switch isPrototype {
                    case "Prototype":
                        self.goPrototype(data: constant.OtpRespose)
                    case "Deck":
                        self.handleDeck(data: constant.OtpRespose)
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
        self.techShowHide()
        self.navigationController?.navigationBar.isHidden = true
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    fileprivate func goDeckVC(data: [String]?) throws {
        DispatchQueue.main.async {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController
        if data != nil && data!.count >= 2 {
            if data![1] != "" {
                vc?.deckLink = data![1]
                print(data)
        }
        }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    @IBAction func seePdfAction(_ sender: Any) {
        
        if constant.isVerify {
            self.handleDeck(data: constant.OtpRespose)
        }else {
            openAlert(isPrototype: "Deck")
        }
        
    }
    
    @IBAction func technicalPdfAction(_ sender: Any) {
        DispatchQueue.main.async {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController
            vc?.deckLink = "https://baller-ac.s3.amazonaws.com/tech_doc.pdf"
            vc?.loadingText = "Document Loading..."
            self.navigationController?.pushViewController(vc!, animated: true)
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
    let message: String?
    let tester_name: String?
    let prototype_url: String?
    let deck_url: String?
}

