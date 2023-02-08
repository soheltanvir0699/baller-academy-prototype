//
//  ScheduleViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 3/2/23.
//

import UIKit
import WebKit

class ScheduleViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = URL(string:"https://calendly.com/balleracademyapp/30min")!
        let request = URLRequest(url: link)
        self.webView!.isOpaque = true
        self.webView!.backgroundColor = UIColor.clear
        self.webView!.scrollView.backgroundColor = UIColor.clear
        if #available(iOS 14.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        } else {
            // Fallback on earlier versions
        }
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.load(request)
        self.navigationController?.navigationBar.isHidden = false
        setNavigation()
        
    }
    
    func setNavigation() {
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var offset = scrollView.contentOffset.y / 1500
        if offset >= 1 {
            offset = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(offset)
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(offset)
        }
    }
    
}
