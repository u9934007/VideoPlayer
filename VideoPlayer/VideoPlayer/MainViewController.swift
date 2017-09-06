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

    // MARK: Property

    var aVPlayerView =  UIView()

    var aVPlayer = AVPlayer()

    let aVPlayerViewController = AVPlayerViewController()

    var searchBarView =  UIView()

    let searchController: UISearchController

    let playButton = UIButton()

    let muteButton = UIButton()

    let buttonView = UIView()

    var isPlaying = false

    // MARK: Init

    init() {

        self.searchController = UISearchController(searchResultsController: nil)

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBarView()

        setUpSearchController()

        setUpAVPlayer()

        setUpButtonView()

        setUpPlayButton()

        setUpMuteButton()

    }

    // MARK: viewWillLayoutSubviews

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setUpSearchBarViewConstraints()

        setUpAVPlayerLayerConstraints()

    }

    // MARK: SetUp

    func setUpSearchBarView() {

        searchBarView.backgroundColor = UIColor.red

        searchBarView.translatesAutoresizingMaskIntoConstraints = false

        searchBarView.frame = CGRect(x: 0.0, y: 20.0, width: view.bounds.width, height: 44.0)

        view.addSubview(searchBarView)

    }

    func setUpSearchController() {

        searchController.searchBar.sizeToFit()

        searchBarView.addSubview(searchController.searchBar)

        searchController.searchBar.placeholder = "Enter URL of video"

        searchController.searchResultsUpdater = self

        searchController.searchBar.searchBarStyle = .prominent

        searchController.dimsBackgroundDuringPresentation = false

    }

    func setUpAVPlayer() {

        aVPlayerView.backgroundColor = UIColor.blue

        aVPlayerView.frame = CGRect(x: 0.0, y: 64.0, width: view.bounds.width, height: view.bounds.height - 108.0)

        view.addSubview(aVPlayerView)

        addChildViewController(aVPlayerViewController)

        aVPlayerViewController.view.frame = CGRect(x: 0, y: 0, width:  aVPlayerView.frame.width, height: aVPlayerView.frame.height)

        aVPlayerViewController.showsPlaybackControls = false

        aVPlayerView.addSubview(aVPlayerViewController.view)

        aVPlayer.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(), context: nil)

    }

    func setUpButtonView() {

        buttonView.frame = CGRect(x: 0.0, y: view.bounds.height - 44.0, width: view.bounds.width, height: 44.0)

        view.addSubview(buttonView)

    }

    func setUpPlayButton() {

        playButton.frame = CGRect(x: 20.0, y: 0, width: 80.0, height: 30.0)

        playButton.center.y = buttonView.frame.height/2

        playButton.setTitle("Play", for: .normal)

        playButton.setTitleColor(UIColor.white, for: .normal)

        playButton.addTarget(
            self,
            action: #selector(playAndPause),
            for: .touchUpInside)

        buttonView.addSubview(playButton)

    }

    func setUpMuteButton() {

        muteButton.frame = CGRect(x: view.bounds.width - 106.0, y:  0, width: 80.0, height: 30.0)

        muteButton.center.y = buttonView.frame.height/2

        muteButton.setTitle("Mute", for: .normal)

        muteButton.setTitleColor(UIColor.white, for: .normal)

        muteButton.addTarget(
            self,
            action: #selector(muteAndUnmute),
            for: .touchUpInside)

        buttonView.addSubview(muteButton)

    }

    // MARK: SetUpConstraints

    func setUpSearchBarViewConstraints() {

        searchBarView.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: searchBarView,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)

        let topConstraint = NSLayoutConstraint(item: searchBarView,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: view,
                                               attribute: NSLayoutAttribute.top,
                                               multiplier: 1,
                                               constant: 20)

        let widthConstraint = NSLayoutConstraint(item: searchBarView,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutAttribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: view.bounds.width)

        let heightConstraint = NSLayoutConstraint(item: searchBarView,
                                                  attribute: NSLayoutAttribute.height,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 44.0)

        view.addConstraints([horizontalConstraint,
                             topConstraint,
                             widthConstraint,
                             heightConstraint
            ])

    }

    func setUpAVPlayerLayerConstraints() {

        aVPlayerView.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: aVPlayerView,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)

        let topConstraint = NSLayoutConstraint(item: aVPlayerView,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: searchBarView,
                                               attribute: NSLayoutAttribute.bottom,
                                               multiplier: 1,
                                               constant: 0)

        let widthConstraint = NSLayoutConstraint(item: aVPlayerView,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutAttribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: view.bounds.width)

        let bottomConstraint = NSLayoutConstraint(item: aVPlayerView,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: view,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  multiplier: 1,
                                                  constant: 0)

        view.addConstraints([horizontalConstraint,
                             topConstraint,
                             widthConstraint,
                             bottomConstraint
            ])

    }

    // MARK: observeValue

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        guard let player = object as? AVPlayer
            else { return }

        if keyPath == "rate" {

            switch player.rate {

            case 0.0 :
                isPlaying = false
                playButton.setTitle("Play", for: .normal)

            default:
                isPlaying = true
                playButton.setTitle("Pause", for: .normal)

            }

        }

    }

    // MARK: Button Action

    func playAndPause() {

        if isPlaying {

            aVPlayer.pause()

        } else {

            aVPlayer.play()

        }

    }

    func muteAndUnmute() {

        if aVPlayer.isMuted {

            aVPlayer.isMuted = false

            muteButton.setTitle("Mute", for: .normal)

        } else {

            aVPlayer.isMuted = true

            muteButton.setTitle("Unmute", for: .normal)

        }

    }

}

// MARK: UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard
            let searchText = searchController.searchBar.text,
            let searchURL = URL(string: searchText)
            else { return }

        aVPlayer.removeObserver(self, forKeyPath: "rate")

        aVPlayer = AVPlayer(url: searchURL)

        aVPlayerViewController.player = aVPlayer

        aVPlayer.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(), context: nil)

        aVPlayer.play()

    }

}
