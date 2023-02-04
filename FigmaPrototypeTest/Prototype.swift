//
//  ViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 10/1/23.
//

import UIKit
import WebKit
import NotificationToast

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        let link = URL(string:"https://www.figma.com/proto/9af6kpJB18dEZGcRmcX18G/Prototype-Test?node-id=2309%3A20362&scaling=min-zoom&page-id=22%3A5297&starting-point-node-id=618%3A12289")!
        let request = URLRequest(url: link)
        self.webView!.isOpaque = true
        self.webView!.backgroundColor = UIColor.clear
        self.webView!.scrollView.backgroundColor = UIColor.clear
        if #available(iOS 14.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        } else {
            // Fallback on earlier versions
        }
        addLongPressGesture()
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        recognizer.delegate = self
//        self.webView!.scrollView.addGestureRecognizer(recognizer)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.load(request)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        self.backImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
//        if #available(iOS 13.0, *) {
//            let toast = ToastViewL(
//                title: "Back to home",
//                titleFont: .systemFont(ofSize: 13, weight: .regular),
//                subtitle: "Long press on this page",
//                subtitleFont: .systemFont(ofSize: 11, weight: .light),
//                icon: UIImage(systemName: "gobackward.minus"),
//                iconSpacing: 16,
//                position: .bottom,
//                onTap: { print("Tapped!") }
//            )
//            toast.show()
//        } else {
//            // Fallback on earlier versions
//            let toast = ToastViewL(
//                title: "Back to home",
//                titleFont: .systemFont(ofSize: 13, weight: .regular),
//                subtitle: "Long press on this page",
//                subtitleFont: .systemFont(ofSize: 11, weight: .light),
//                iconSpacing: 16,
//                position: .bottom,
//                onTap: { print("Tapped!") }
//            )
//            toast.show()
//        }
       
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func addLongPressGesture() {
        
    }

    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Perform your functionality here
            backAction()
        }
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func willMove(toParent: UIViewController? ) {
        print("Something")
    }
    
    @objc func update() {
        webView.evaluateJavaScript("document.querySelector('.vjs-text-track-display vjs-hidden').style.display='none';", completionHandler: { (response, error) -> Void in
            })
        webView.evaluateJavaScript("document.querySelector('.vjs-text-track-display').style.display='none';", completionHandler: { (response, error) -> Void in
            })
        webView.evaluateJavaScript("document.querySelector('.vjs-hidden').style.display='none';", completionHandler: { (response, error) -> Void in
            })

        webView.evaluateJavaScript("document.querySelector('.prototype--footerContainer--G2XHU').remove();", completionHandler: { (response, error) -> Void in
            })
        webView.evaluateJavaScript("document.querySelector('.header--header--7nw-A').remove();", completionHandler: { (response, error) -> Void in
            })
        webView.evaluateJavaScript("document.querySelector('.header--header--7nw-A header--headerHidden--ML9n5').remove();", completionHandler: { (response, error) -> Void in
            })
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.querySelector('.prototype--footerContainer--G2XHU').remove();", completionHandler: { (response, error) -> Void in

            })
        webView.evaluateJavaScript("document.querySelector('.header--header--7nw-A header--headerHidden--ML9n5').remove();", completionHandler: { (response, error) -> Void in

            })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

