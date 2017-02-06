//
//  MainViewController.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import UIKit

let ParliamentFeedCellIdentifier = "ParliamentFeedCellIdentifier"

class MainViewController: UIViewController , UIViewControllerPreviewingDelegate , UITableViewDataSource , UITableViewDelegate
{
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var parliamentFeeds = [ParliamentInfo]()
    var previewedFeed : ParliamentInfo?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupSegmentedControl()
        self.tableView.register(UINib.init(nibName: String(describing: ParliamentFeedCell.self), bundle: nil), forCellReuseIdentifier: ParliamentFeedCellIdentifier)
        self.tableView.estimatedRowHeight = 125.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.edgesForExtendedLayout = []
        
        if traitCollection.forceTouchCapability == .available
        {
            registerForPreviewing(with: self, sourceView: self.tableView)
        }
        
        self.navigationItem.titleView = UINavigationController.navigationBarDemocracyLogo()
        self.getDates()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()    
    }
    
    
    func setupSegmentedControl()
    {
        self.segmentedControl.setTitle(NSLocalizedString("Kommande", comment: ""), forSegmentAt: 0);
        self.segmentedControl.setTitle(NSLocalizedString("Avslutade", comment: ""), forSegmentAt: 1);
    }
    
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.parliamentFeeds.count;
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ParliamentFeedCellIdentifier) as! ParliamentFeedCell
        
        let parliamentInfo = self.parliamentFeeds[indexPath.row]
        
        cell.titleLabel.text = parliamentInfo.rubrik
        cell.descLabel.text = "Förslag från: \(parliamentInfo.organ)"
        
        return cell
    }

    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let parliamentInfo = self.parliamentFeeds[indexPath.row]
        
        let viewController = FeedDetailViewController()        
        viewController.feedTitle = parliamentInfo.rubrik
        viewController.feedDesc = parliamentInfo.organ        
        viewController.feedProposed = parliamentInfo.forslag
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    
    // MARK: UIViewControllerPreviewingDelegate
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        let feedDetailVC = FeedDetailViewController()
        
        guard let indexPath = self.tableView?.indexPathForRow(at: location) else
        {
            return nil
        }
        
        let row = indexPath.row
        let info = self.parliamentFeeds[row]
        
        feedDetailVC.feedTitle = info.rubrik
        feedDetailVC.feedDesc = info.organ
        feedDetailVC.feedProposed = info.forslag
        
        self.previewedFeed = info
        
        return feedDetailVC
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        let feedDetailVC = FeedDetailViewController()
        
        feedDetailVC.feedTitle = (self.previewedFeed?.rubrik)!
        feedDetailVC.feedDesc = (self.previewedFeed?.organ)!
        feedDetailVC.feedProposed = (self.previewedFeed?.forslag)!

        self.navigationController?.pushViewController(feedDetailVC, animated: true);
    }

    
    // MARK : Private Method - To be re-factor 
    func getDates() {
        NetworkManager.sharedInstance.getDates { (error, date) in
            
            self.getDocId(date: date)
        }
    }
    
    func getDocId(date: String) {
        NetworkManager.sharedInstance.getDocId(date: date, completionHandler: { (error, dok_id, organName) in
            
            self.getDocInfoFromId(dok_id: dok_id, organ: organName)
        })
    }
    
    func getDocInfoFromId(dok_id: String, organ: String) {
        NetworkManager.sharedInstance.getDocInfoFromId(dok_id: dok_id, organ: organ, completionHandler:
            { (error, contentArray) in
                
                self.parliamentFeeds = contentArray
                self.tableView.reloadData()
                print(contentArray)
                
        })
    }

}
