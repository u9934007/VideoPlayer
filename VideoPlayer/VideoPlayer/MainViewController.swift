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

    // MARK: Init

    init() {

        self.searchController = UISearchController(searchResultsController: nil)

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Viewdidload

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBarView()

        setUpSearchController()

        setUpAVPlayer()

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

//        setUpSearchBarViewConstraints()
//
//        setUpAVPlayerLayerConstraints()

    }

    func setUpSearchBarView() {

        searchBarView.backgroundColor = UIColor.red

        searchBarView.translatesAutoresizingMaskIntoConstraints = false

        searchBarView.frame = CGRect(x: 0.0, y: 20.0, width: view.bounds.width, height: 44.0)

        view.addSubview(searchBarView)

        self.addChildViewController(aVPlayerViewController)

        aVPlayerViewController.view.frame = searchBarView.frame

        self.aVPlayerView.addSubview(aVPlayerViewController.view)

    }

    func setUpSearchController() {

        searchController.searchBar.sizeToFit()

        searchBarView.addSubview(searchController.searchBar)

        searchController.searchBar.placeholder = "Enter URL of video"

        searchController.searchResultsUpdater = self

        searchController.searchBar.searchBarStyle = .prominent

    }

    func setUpAVPlayer() {

        aVPlayerView.frame = CGRect(x: 0.0, y: 64.0, width: view.bounds.width, height: 603.0)

        view.addSubview(aVPlayerView)

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

}

// MARK: UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard
            let searchText = searchController.searchBar.text,
            let searchURL = URL(string: searchText)
            else { return }

        aVPlayer = AVPlayer(url: searchURL)

        aVPlayerViewController.player = aVPlayer

        aVPlayer.play()

    }

}
