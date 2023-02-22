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
import Mute

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate,SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    var prototypeLink = constant.defaultProtypeLink
    private var audioLevel : Float = 0.0
    private var tapCout = 0
    var current = false
    var isFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.isHidden = true
        let link = URL(string:prototypeLink)!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    
    func listenVolumeButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.showToast(message: "Toggle silent button to exit prototype")
        }
        let volumeView = MPVolumeView(frame: CGRect(x: -CGFloat.greatestFiniteMagnitude, y: 0.0, width: 0.0, height: 0.0))
        self.view.addSubview(volumeView)
        
//        NotificationCenter.default.addObserver(forName: AVAudioSession.silenceSecondaryAudioHintNotification, object: nil, queue: nil) { notification in
//            let isSilent = AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
//            self.apiCallFuncTest(TestString: "local call")
//            self.backAction()
//        }
        
        // Notify every 2 seconds
        Mute.shared.checkInterval = 1.5

        // Always notify on interval
        Mute.shared.alwaysNotify = true

        // Update label when notification received
        Mute.shared.notify = { [weak self] m in
            print(m)
            if self!.isFirst == false {
                self!.current = m
                self!.isFirst = true
            }else {
            if self!.current != m {
                self!.current = m
                DispatchQueue.main.async {
                    Mute.shared.isPaused = true
                }
//                self!.apiCallFuncTest(TestString: "Library call")
                self!.backAction()
            }
            }
            print(m)
        }

//         Stop after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Mute.shared.isPaused = true
        }

        // Re-start after 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            Mute.shared.isPaused = false
        }
    }
    
    func apiCallFuncTest(TestString: String) {
        
        let urlString = "https://messagealarm.app/api/test_func/"
        guard let url = URL(string: urlString) else { return }
        
        let parameters = [
            "count": TestString
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
           
        }.resume()
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
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        showToast(message: "Thanks for your visit!")
        DispatchQueue.main.async {
            Mute.shared.isPaused = true
        }
        UIApplication.shared.isStatusBarHidden = false
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
    
    override var prefersStatusBarHidden: Bool {
        print("status bar")
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

