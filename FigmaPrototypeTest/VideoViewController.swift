//
//  VideoViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 1/2/23.
//

import UIKit
import VGPlayer
import SnapKit



class VideoViewController: UIViewController {
    
    var player : VGPlayer?
    var openSmall = false
    var smallScreenView = UIView()
    var videoUrl : URL?
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if videoUrl != nil {
            player = VGPlayer(URL: videoUrl!)
        }
        self.view.addSubview(player!.displayView)
        player!.play()
        player?.backgroundMode = .suspend
        player?.delegate = self
        player?.displayView.titleLabel.text = ""
        player?.displayView.delegate = self
        player?.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.edges.equalTo(strongSelf.view)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player!.pause()
    }

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
