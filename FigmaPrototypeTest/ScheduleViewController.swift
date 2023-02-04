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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
