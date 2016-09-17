//
//  HomeFeedViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var videoTable: UITableView!

    var homeFeed = [Video]()
    var refreshControl: UIRefreshControl!
    var index = 0
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setRefresh()
        setTable()
        setTitleLogo()
        loadFeed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeFeed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:VideoViewCell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoViewCell), forIndexPath: indexPath) as! VideoViewCell
        cell.cellData = homeFeed[indexPath.row]
        if (homeFeed.count - 1) == indexPath.row {
            loadFeed()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("selectVideo", sender: self)
    }
    
    
    // MARK: Data Logic
    func loadFeed(){
//        ManagerLocator.sharedInstance.videoManager.loadMockFeed(page)
        ManagerLocator.sharedInstance.videoManager.loadFeed(page)
    }
    
    func pullToRefresh(){
        page = 1
        loadFeed()
    }
    
    // MARK: Design
    func setRefresh(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.pullToRefresh), forControlEvents: UIControlEvents.ValueChanged)
        videoTable.insertSubview(refreshControl, atIndex: 0)
    }
    
    func setTable(){
        let nib: UINib = UINib(nibName: "VideoViewCell", bundle: nil)
        videoTable.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoViewCell))
        videoTable.delegate = self
        videoTable.dataSource = self
        videoTable.estimatedRowHeight = 200
        videoTable.rowHeight = UITableViewAutomaticDimension
        ManagerLocator.sharedInstance.videoManager.videoFeed.afterChange.add(owner: self) {
            value in
            self.homeFeed = ManagerLocator.sharedInstance.videoManager.videoFeed.value
            self.refreshControl.endRefreshing()
            self.videoTable.reloadData()
        }
    }
    
    func setTitleLogo(){
        let titleLogo = UIImageView(frame: CGRectMake(0,0,25,25))
        titleLogo.contentMode = .ScaleAspectFit
        titleLogo.image = UIImage(named: "ic_nav_logo")
        navigationItem.titleView = titleLogo
    }

    // MARK: Transition logic
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectVideo"{
            let videoViewController: VideoViewController = segue.destinationViewController as! VideoViewController
            videoViewController.hidesBottomBarWhenPushed = true
            videoViewController.video = homeFeed[index]
        }
    }
    
}
