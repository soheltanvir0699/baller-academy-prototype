//
//  ProfileViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 4/2/23.
//

import UIKit
import Glideshow

class ProfileViewController: UIViewController {
    
    private var shouldCollapse = false
    var buttonTitle: String {
    return shouldCollapse ? "0" : "1"
    }
    
    private var shouldCollapseLouren = false
    var buttonLourenTitle: String {
    return shouldCollapseLouren ? "0" : "1"
    }
    
    private var shouldCollapseMujahid = false
    var buttonMujahidTitle: String {
    return shouldCollapseMujahid ? "0" : "1"
    }
    var nathanViewHeight = 0.0
    
    @IBOutlet weak var mujahidView: UIView!
    @IBOutlet weak var louremView: UIView!
    @IBOutlet weak var nathanArrow: UIImageView!
    @IBOutlet weak var louremArrow: UIImageView!
    @IBOutlet weak var mujaArrow: UIImageView!
    @IBOutlet weak var mujahidBtn: UIButton!
    @IBOutlet weak var lourenBtn: UIButton!
    @IBOutlet weak var lourenHeight: NSLayoutConstraint!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var nathanView: UIView!
    @IBOutlet weak var sliderView: Glideshow!
    @IBOutlet weak var mujahidHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nathanHeight: NSLayoutConstraint!
    @IBOutlet weak var galleryImg: UIImageView!
    @IBOutlet weak var galleryView: UIView!
    
    @IBOutlet weak var galleryViewTwo: UIView!
    @IBOutlet weak var galleryImgTwo: UIImageView!
    
    @IBOutlet weak var galleryViewThree: UIView!
    @IBOutlet weak var galleryImgThree: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isTranslucent = false
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.nathanViewHeight = self.nathanView.frame.height
            
            
            
            DispatchQueue.main.async {
                self.lourenHeight.constant = 0
                self.mujahidHeight.constant = 0
                self.nathanHeight.constant = 0
                self.mujahidView.isHidden = true
                self.louremView.isHidden = true
                self.nathanView.isHidden = true
                self.galleryImg.layer.cornerRadius = 5
                self.galleryView.layer.cornerRadius = 5
                self.galleryImgTwo.layer.cornerRadius = 5
                self.galleryViewTwo.layer.cornerRadius = 5
                self.galleryImgThree.layer.cornerRadius = 5
                self.galleryViewThree.layer.cornerRadius = 5
        }
            
            self.galleryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails)))
            self.galleryViewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails2)))
            self.galleryViewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails3)))
        
        }
        sliderView.items = [
            GlideItem(title : "", description: "", backgroundImage: UIImage(named:  "1")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "2")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "3")),
            GlideItem(title : "", description: "", backgroundImage: UIImage(named:  "1")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "4")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "5")),
            GlideItem(title : "", description: "", backgroundImage: UIImage(named:  "1")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "6")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "7")),
            GlideItem(title : "", description: "", backgroundImage: UIImage(named:  "8")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "9"))
        ]
        sliderView.delegate = self
        sliderView.isCircular = true
        sliderView.gradientColor =
            UIColor.black.withAlphaComponent(0.8)
        sliderView.captionFont = UIFont.systemFont(ofSize: 16, weight: .light)
        sliderView.titleFont = UIFont.systemFont(ofSize: 30, weight: .black)
        sliderView.gradientHeightFactor = 0.8
        sliderView.pageIndicatorPosition = .bottom
        sliderView.interval = 5
    }
    
    @objc func goVideoDetails() {
        
       goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/baller_unicef.mp4")
    }
    @objc func goVideoDetails2() {
        
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/baller_highlights.mp4")
    }
    @objc func goVideoDetails3() {
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/baller_city_of_houston.mp4")
        
    }
    func goDetailsVc(url: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
        vc?.videoUrl = URL(string: url)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
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
          //  self.navigationController?.navigationBar.alpha = offset
          //  print(offset - 0.399)
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(offset)
        }
    }
    @IBAction func mujahidCollapseAction(_ sender: Any) {
        if shouldCollapseMujahid {
              animateMujahidView(isCollapse: false,
              buttonText: buttonMujahidTitle,
              heighConstraint: 0)
           } else {
               animateMujahidView(isCollapse: true,
               buttonText: buttonMujahidTitle,
               heighConstraint: 338)
           }
    }
    
    @IBAction func lourenCollapseAction(_ sender: Any) {
        if shouldCollapseLouren {
              animateLourenView(isCollapse: false,
              buttonText: buttonLourenTitle,
              heighConstraint: 0)
           } else {
               animateLourenView(isCollapse: true,
               buttonText: buttonLourenTitle,
               heighConstraint: 338)
           }
    }
    
    @IBAction func NathanCollapseAction(_ sender: Any) {
        if shouldCollapse {
              animateView(isCollapse: false,
              buttonText: buttonTitle,
              heighConstraint: 0)
           } else {
               animateView(isCollapse: true,
               buttonText: buttonTitle,
               heighConstraint: nathanViewHeight)
           }
    }
    
    private func animateView(isCollapse: Bool,
    buttonText: String,
    heighConstraint: Double) {
        if !isCollapse == true {
            nathanArrow.image = UIImage(named: "Left")
            showHideView(view: nathanView, isHide: true)
        }else {
            animateLourenView(isCollapse: false,
            buttonText: buttonLourenTitle,
            heighConstraint: 0)
            animateMujahidView(isCollapse: false,
            buttonText: buttonMujahidTitle,
            heighConstraint: 0)
            nathanArrow.image = UIImage(named: "down")
            showHideView(view: nathanView, isHide: false)
        }
         shouldCollapse = isCollapse
        nathanHeight.constant = CGFloat(heighConstraint)
        UIView.animate(withDuration: 0.7) {
              self.view.layoutIfNeeded()
         }
    }
    
    private func animateLourenView(isCollapse: Bool,
    buttonText: String,
    heighConstraint: Double) {
        if !isCollapse == true {
            louremArrow.image = UIImage(named: "Left")
            showHideView(view: louremView, isHide: true)
        }else {
            animateMujahidView(isCollapse: false,
            buttonText: buttonMujahidTitle,
            heighConstraint: 0)
            animateView(isCollapse: false,
            buttonText: buttonTitle,
            heighConstraint: 0)
            louremArrow.image = UIImage(named: "down")
            showHideView(view: louremView, isHide: false)
        }
         shouldCollapseLouren = isCollapse
         lourenHeight.constant = CGFloat(heighConstraint)
        UIView.animate(withDuration: 0.7) {
              self.view.layoutIfNeeded()
         }
    }
    
    private func animateMujahidView(isCollapse: Bool,
    buttonText: String,
    heighConstraint: Double) {
        if !isCollapse == true {
            mujaArrow.image = UIImage(named: "Left")
            showHideView(view: mujahidView, isHide: true)
        }else {
            animateView(isCollapse: false,
            buttonText: buttonTitle,
            heighConstraint: 0)
            animateLourenView(isCollapse: false,
            buttonText: buttonLourenTitle,
            heighConstraint: 0)
            mujaArrow.image = UIImage(named: "down")
            showHideView(view: mujahidView, isHide: false)
        }
         shouldCollapseMujahid = isCollapse
         mujahidHeight.constant = CGFloat(heighConstraint)
        UIView.animate(withDuration: 0.7) {
              self.view.layoutIfNeeded()
         }
    }
    
    func showHideView(view: UIView, isHide:Bool) {
        DispatchQueue.main.async {
            view.isHidden = isHide
        }
        
    }

}

extension ProfileViewController : GlideshowProtocol {
    func glideshowDidSelecteRowAt(indexPath: IndexPath, _ glideshow: Glideshow) {
        print(indexPath)
    }
    
    func pageDidChange(_ glideshow: Glideshow, didChangePageTo page: Int) {
        print(page)
    }
}
