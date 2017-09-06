//
//  MainViewController.swift
//  VideoPlayer
//
//  Created by 楊采庭 on 2017/9/6.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {
    
    var playerLayer: AVPlayerLayer?
    let aVPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red

    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        playerLayer?.frame = self.view.bounds
    
    }

}
