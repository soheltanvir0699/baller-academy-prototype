//
//  VideoViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 1/2/23.
//

import UIKit
import VGPlayer
import SnapKit

var player : VGPlayer = {
    let playeView = VGCustomPlayerView()
    let playe = VGPlayer(playerView: playeView)
    return playe
}()
var url : URL?
var openSmall = false

class VideoViewController: UIViewController {
    var smallScreenView = UIView()

    @IBOutlet weak var videoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "2", ofType: "mp4")!)
        player.replaceVideo(url)
        videoView.addSubview(player.displayView)
        player.play()
        player.backgroundMode = .suspend
        player.delegate = self
        
        player.displayView.delegate = self
        player.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.videoView.snp.top)
            make.left.equalTo(strongSelf.videoView.snp.left)
            make.right.equalTo(strongSelf.videoView.snp.right)
            make.height.equalTo(strongSelf.videoView.snp.width).multipliedBy(9.0/16.0) // you can 9.0/16.0
        }
        
//        addSmallScreenView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
        player.play()
        if openSmall == true {
            smallScreenView.removeFromSuperview()
            openSmall = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: false)
//        UIApplication.shared.setStatusBarHidden(false, with: .none)
        player.pause()
//        addSmallScreenView()
    }
    
    func addSmallScreenView() {
//            player.displayView.removeFromSuperview()
//            smallScreenView.removeFromSuperview()
//            playerView.isSmallMode = true
        UIApplication.shared.keyWindow?.addSubview(smallScreenView)
//            let smallScreenWidth = (playerViewSize?.width)! / 2
//            let smallScreenHeight = (playerViewSize?.height)! / 2
//        smallScreenView.snp.remakeConstraints {
//            $0.bottom.equalTo(self.view.snp.bottom).offset(-10)
//            $0.right.equalTo(self.view.snp.right).offset(-10)
//            $0.width.equalTo(150)
//            $0.height.equalTo(70)
//        }
        openSmall = true
        smallScreenView.frame = CGRect(x: self.view.frame.width-200, y: self.view.frame.height-100, width: 200, height: 100)
        smallScreenView.backgroundColor = .white
            smallScreenView.addSubview(player.displayView)
            player.displayView.snp.remakeConstraints {
                $0.edges.equalTo(smallScreenView)
            }
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

extension VideoViewController: VGPlayerDelegate {
    func vgPlayer(_ player: VGPlayer, playerFailed error: VGPlayerError) {
        print(error)
    }
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print("player State ",state)
    }
    func vgPlayer(_ player: VGPlayer, bufferStateDidChange state: VGPlayerBufferstate) {
        print("buffer State", state)
    }
    
}

extension VideoViewController: VGPlayerViewDelegate {
    
    
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        
    }
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            playerView.exitFullscreen()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .fade)
    }
}
