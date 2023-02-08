//
//  ViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 10/1/23.
//

import UIKit
import WebKit
import NotificationToast
import Speech
import MediaPlayer
import AVFoundation

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate,SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    private var audioLevel : Float = 0.0
    private var tapCout = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //        userAutorization()
        
        // Do any additional setup after loading the view.
        let link = URL(string:"https://www.figma.com/proto/9af6kpJB18dEZGcRmcX18G/Prototype-Test?node-id=2309%3A20362&scaling=min-zoom&page-id=22%3A5297&starting-point-node-id=618%3A12289")!
        let request = URLRequest(url: link)
        DispatchQueue.main.async {
            
            self.webView!.isOpaque = true
            self.webView!.backgroundColor = UIColor.clear
            self.webView!.scrollView.backgroundColor = UIColor.clear
            if #available(iOS 14.0, *) {
                self.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
            } else {
                // Fallback on earlier versions
            }
        }
        //        self.webView!.scrollView.addGestureRecognizer(recognizer)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.load(request)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        self.backImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        listenVolumeButton()
    }
    
    
    func listenVolumeButton(){
        showToast(message: "Press volume down button to exit prototype")
        let audioSession = AVAudioSession.sharedInstance()
        
            do {
                try audioSession.setActive(true, options: [])
            } catch {
                print("Error setting audio session active: \(error)")
                return
            }
            
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        audioLevel = audioSession.outputVolume
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            backAction()
        }
    }
    
    func showToast(message: String) {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let toast = ToastViewL(
                    title: message,
                    titleFont: .systemFont(ofSize: 13, weight: .regular),
                    subtitleFont: .systemFont(ofSize: 11, weight: .light),
                    backgroundColorView: .systemBlue, iconSpacing: 16,
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
                    backgroundColorView: .systemBlue, iconSpacing: 16,
                    position: .bottom,
                    onTap: { print("Tapped!") }
                )
                toast.show()
            }
        }
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        showToast(message: "Thanks for your visit!")
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func willMove(toParent: UIViewController? ) {
        print("Something")
    }
    
    @objc func update() {
        tapCout = 0
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
    
    
    func userAutorization(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
        }
    }
    
    
}

