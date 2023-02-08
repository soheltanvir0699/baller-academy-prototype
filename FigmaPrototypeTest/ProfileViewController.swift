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
    private var shouldCollapseLouren = false
    private var shouldCollapseMujahid = false
    var nathanViewHeight = 0.0
    var mujahidViewHeight = 0.0
    
    var buttonMujahidTitle: String {
        return shouldCollapseMujahid ? "0" : "1"
    }
    var buttonLourenTitle: String {
        return shouldCollapseLouren ? "0" : "1"
    }
    var buttonTitle: String {
        return shouldCollapse ? "0" : "1"
    }
    
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
    
    @IBOutlet weak var mujahidSlider: Glideshow!
    @IBOutlet weak var nathanHeight: NSLayoutConstraint!
    @IBOutlet weak var galleryImg: UIImageView!
    @IBOutlet weak var galleryView: UIView!
    
    @IBOutlet weak var galleryViewTwo: UIView!
    @IBOutlet weak var galleryImgTwo: UIImageView!
    
    @IBOutlet weak var galleryViewThree: UIView!
    @IBOutlet weak var galleryImgThree: UIImageView!
    
    @IBOutlet weak var galleryViewFour: UIView!
    @IBOutlet weak var galleryImgFour: UIImageView!
    
    @IBOutlet weak var mujaGalleryViewOne: UIView!
    @IBOutlet weak var mujaGalleryViewTwo: UIView!
    @IBOutlet weak var mujaGalleryViewThree: UIView!
    
    @IBOutlet weak var MujaGalleryImgOne: UIImageView!
    @IBOutlet weak var MujaGalleryImgTwo: UIImageView!
    @IBOutlet weak var MujaGalleryImgThree: UIImageView!
    
    @IBOutlet weak var careerOneLbl: UILabel!
    @IBOutlet weak var careerTwoLbl: UILabel!
    @IBOutlet weak var careerThreeLbl: UILabel!
    @IBOutlet weak var careerFourLbl: UILabel!
    @IBOutlet weak var careerFiveLbl: UILabel!
    @IBOutlet weak var careerSixLbl: UILabel!
    @IBOutlet weak var careerSecondLbl: UILabel!
    
    func setText(label:UILabel, textRegular:String, textBold: String) {
        let regularFont = UIFont(name: "Helvetica", size: 14)
        let boldFont = UIFont(name: "Helvetica-Bold", size: 14)

        let regularAttributes = [NSAttributedString.Key.font: regularFont]
        let boldAttributes = [NSAttributedString.Key.font: boldFont]

        let attributedText = NSMutableAttributedString(string: textBold, attributes: boldAttributes as [NSAttributedString.Key : Any])

        attributedText.append(NSAttributedString(string: "\n" + textRegular, attributes: regularAttributes as [NSAttributedString.Key : Any]))

        label.attributedText = attributedText
    }
    let boldArray = ["Chief Technology Officer","Lead Software Engineer","Chief Technology Officer & Co - Founder","Senior Software Engineer","Executive Software Engineer","Android Development - Trainer","Freelance Android & Web developer"]
    let regularArray = ["Baller Academy, United States (Feb 2023 - Current)","Baller Academy, United States (Jan 2022 - Jan 2023)","Mk7Lab, Khulna (Dec 2021 -  Jan 2022)","Ruhof Corporation , New York (Jan 2019 - Dec 2021)","ItechSoftSolution, Khulna (Dec 2017 -  Jan 2019)","Digicon Technologies, Dhaka (Jan 2016 -  Dec 2017)","Upwork &amp; Fiverr (Jan 2013 -  Dec 2015)"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let labels = [self.careerOneLbl, self.careerSecondLbl, self.careerTwoLbl, self.careerThreeLbl, self.careerFourLbl,self.careerFiveLbl,self.careerSixLbl]
        for (index,lab) in labels.enumerated() {
            setText(label: lab!, textRegular: regularArray[index], textBold: boldArray[index])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.nathanViewHeight = self.nathanView.frame.height
            self.mujahidViewHeight = self.mujahidView.frame.height
            
            DispatchQueue.main.async {
                self.lourenHeight.constant = 0
                self.mujahidHeight.constant = 0
                self.nathanHeight.constant = 0
                self.mujahidView.isHidden = true
                self.louremView.isHidden = true
                self.nathanView.isHidden = true
                let images = [self.galleryImg, self.galleryImgTwo, self.galleryImgThree, self.galleryImgFour,self.MujaGalleryImgOne,self.MujaGalleryImgTwo,self.MujaGalleryImgThree]
                let views = [self.galleryView, self.galleryViewTwo, self.galleryViewThree, self.galleryViewFour,self.mujaGalleryViewOne,self.mujaGalleryViewTwo,self.mujaGalleryViewThree]

                    for i in 0..<images.count {
                        images[i]!.layer.cornerRadius = 5
                        views[i]!.layer.cornerRadius = 5
                    }
            }
            
            self.galleryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails)))
            self.galleryViewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails2)))
            self.galleryViewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails3)))
            self.galleryViewFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetails4)))
            
            self.mujaGalleryViewOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetailsMuja)))
            self.mujaGalleryViewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetailsMuja2)))
            self.mujaGalleryViewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goVideoDetailsMuja3)))
            
        }
        
        mujahidSlider.items = [
            GlideItem(description: "", backgroundImage: UIImage(named:  "mujahid_one")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "mujahid_two")),
            ]
        
        sliderView.items = [
            GlideItem(description: "", backgroundImage: UIImage(named:  "1")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "2")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "3")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "4")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "5")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "6")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "7")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "8")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "9")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "10")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "11")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "12")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "13")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "14")),
            GlideItem(description: "", backgroundImage: UIImage(named:  "15"))
        ]
        let slideViews = [sliderView, mujahidSlider]
        for slide in slideViews {
            slide!.delegate = self
            slide!.isCircular = true
            slide!.gradientColor =
            UIColor.black.withAlphaComponent(0.8)
            slide!.captionFont = UIFont.systemFont(ofSize: 16, weight: .light)
            slide!.titleFont = UIFont.systemFont(ofSize: 30, weight: .black)
            slide!.gradientHeightFactor = 0.8
            slide!.pageIndicatorPosition = .bottom
            slide!.interval = 5
        }
        
        
    }
    
    @IBAction func nathanLinkdinAction(_ sender: UIButton) {
        if sender.tag == 1 {
            openUrl(string: "https://www.linkedin.com/in/pro-mujahid/")
        }else {
        openUrl(string: "https://www.linkedin.com/in/nathan-baller-586573189")
        }
    }
    
    @IBAction func nathanTwitterAction(_ sender: UIButton) {
        if sender.tag == 1 {
            openUrl(string: "https://github.com/mkhan9047")
        }else {
        openUrl(string: "https://twitter.com/nathankouamou1")
        }
    }
    
    @IBAction func nathanInstaAction(_ sender: Any) {
        openUrl(string: "https://instagram.com/nathanballer_?igshid=YmMyMTA2M2Y=")
    }
    
    func openUrl(string:String) {
        
        guard let url = URL(string: string) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @objc func goVideoDetailsMuja() {
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/mujahid_noise_cancel.mp4")
    }
    
    @objc func goVideoDetailsMuja2() {
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/mk_easy.mp4")
    }
    
    @objc func goVideoDetailsMuja3() {
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/message_alarm.mp4")
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
    
    @objc func goVideoDetails4() {
        goDetailsVc(url: "https://baller-ac.s3.amazonaws.com/baller_walmart.mp4")
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
                               heighConstraint: mujahidViewHeight)
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
    
    private func animateMujahidView(isCollapse: Bool, buttonText: String, heighConstraint: Double) {
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
