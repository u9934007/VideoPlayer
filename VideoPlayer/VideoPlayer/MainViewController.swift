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

        view.backgroundColor = UIColor.white

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

    }

    func setUpAVPlayer() {

        aVPlayerView.backgroundColor = UIColor.blue

        aVPlayerView.frame = CGRect(x: 0.0, y: 64.0, width: view.bounds.width, height: 603.0)

        view.addSubview(aVPlayerView)

        addChildViewController(aVPlayerViewController)

        aVPlayerViewController.view.frame = searchBarView.frame

        aVPlayerView.addSubview(aVPlayerViewController.view)

        aVPlayer.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(), context: nil)

    }

    func setUpButtonView() {

        buttonView.frame = CGRect(x: 0.0, y: view.bounds.height - 44.0, width:  view.bounds.width, height: 44.0)

        view.addSubview(buttonView)

    }

    func setUpPlayButton() {

        playButton.frame = CGRect(x: 20.0, y: buttonView.frame.height/2, width: 33.0, height: 19.0)

        playButton.setTitle("Play", for: .normal)

        buttonView.addSubview(playButton)

    }

    func setUpMuteButton() {

        muteButton.frame = CGRect(x: view.bounds.width - 55.0, y:  buttonView.frame.height/2, width: 33.0, height: 19.0)

        muteButton.setTitle("Mute", for: .normal)

        buttonView.addSubview(muteButton)

    }

    func setUpSearchBarViewConstraints() {

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

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("obsrved")
    }

}

// MARK: UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard
            let searchText = searchController.searchBar.text,
            let searchURL = URL(string: searchText)
            else { return }

        aVPlayer.removeObserver(self, forKeyPath: "status")

        aVPlayer = AVPlayer(url: searchURL)

        aVPlayerViewController.player = aVPlayer

        aVPlayer.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(), context: nil)

        aVPlayer.play()

    }

}
