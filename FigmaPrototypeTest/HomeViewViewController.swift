//
//  HomeViewViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 31/1/23.
//

import UIKit
import THPDFKit
import CocoaLumberjack
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
        // Do any additional setup after loading the view.
        
        SwiftyTranslate.translate(text: "my name is sohel", from: "en", to: "bn") { result in
            switch result {
                case .success(let translation):
                    print("Translated: \(translation.translated)")
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
        
    }
    
    
    @IBAction func seePrototype(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func meetTeamAciton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func seePdfAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.viewDeckBtn.startAnimation()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewControllerWrapper") as? PDFViewControllerWrapper
            vc!.url = URL(string: "https://baller-ac.s3.amazonaws.com/deck.pdf")
            self.navigationController?.navigationBar.isHidden = false
            self.viewDeckBtn.stopAnimation()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    
    @IBAction func seeScheduleAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
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
