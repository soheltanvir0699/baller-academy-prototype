//
//  PDFViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 31/1/23.
//

import UIKit
import PDFKit
import ANLoader
class PDFViewController: UIViewController {
    @IBOutlet weak var rightCons: NSLayoutConstraint!
    
    @IBOutlet weak var btnLeftCons: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lefCons: NSLayoutConstraint!
    private var pdfView = PDFView()
    @IBOutlet weak var pdfVieww: UIView!
    var deckLink = constant.defaultDeckLink
    var loadingText = "Deck Loading..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.backgroundColor = .clear
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
            ANLoader.showLoading(self.loadingText, disableUI: false)
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.1) {
            
            self.pdfView.translatesAutoresizingMaskIntoConstraints = false
            self.pdfVieww.addSubview(self.pdfView)
            self.pdfView.maxScaleFactor = 4.0;
            self.pdfView.autoScales = true;
            
            self.pdfView.topAnchor.constraint(equalTo: self.pdfVieww.topAnchor).isActive = true
            self.pdfView.bottomAnchor.constraint(equalTo: self.pdfVieww.bottomAnchor).isActive = true
            self.pdfView.leadingAnchor.constraint(equalTo: self.pdfVieww.leadingAnchor).isActive = true
            self.pdfView.trailingAnchor.constraint(equalTo: self.pdfVieww.trailingAnchor).isActive = true
            
            let sampleDocumentURL = URL(string: self.deckLink)
            let sampleDocument = PDFDocument(url: sampleDocumentURL!)
            
            self.pdfView.document = sampleDocument
            ANLoader.hide()
            self.appCameToForegroundNotification()
        }
    }
    
    @objc func appCameToForeground() {
        print("active to foreground")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            if constant.rotationType != "Document Loading..." {
                print(self.loadingText)
                let value = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
            }else {
                self.lefCons.constant = 0
                self.rightCons.constant = 0
                self.btnLeftCons.constant = 0
                self.backBtn.tintColor = .black
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
            }
        }
    }
    
    @objc func appCameToForegroundNotification() {
        print("active to foreground")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            if constant.rotationType != "Document Loading..." {
                print(self.loadingText)
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }else {
            self.lefCons.constant = 0
            self.rightCons.constant = 0
            self.btnLeftCons.constant = 0
            self.backBtn.tintColor = .black
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if constant.rotationType != "Document Loading..." {
            print(self.loadingText)
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }else {
        self.lefCons.constant = 0
        self.rightCons.constant = 0
        self.btnLeftCons.constant = 0
        self.backBtn.tintColor = .black
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        appCameToForeground()
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
