//
//  ViewController.swift
//  iGovFire3
//
//  Created by iGov Direct on 2016-11-01.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import UIKit
import Alamofire

class ProposedFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    
    var riksdagsArray = [ParliamentInfo]()
    
    @IBOutlet weak var riksdagsFeedTableView: UITableView!
    @IBOutlet var kommerSnartView: UIView!
    @IBOutlet weak var popupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDates()
        
        self.riksdagsFeedTableView.estimatedRowHeight = 200
        self.riksdagsFeedTableView.rowHeight = UITableViewAutomaticDimension
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: riksdagsFeedTableView)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /////////////////////////////////////////////////////////
    @IBAction func beslutButton(_ sender: Any) {
        animateIn()
    }
    @IBAction func lagarButton(_ sender: Any) {
        animateIn()
    }
    @IBAction func dismissPopupView(_ sender: Any) {
        animateOut()
    }
    /////////////////////////////////////////////////////////
    
    typealias JSONStandard = [String : AnyObject]
    
    func animateIn() {
        self.view.addSubview(kommerSnartView)
        kommerSnartView.center = self.view.center
        kommerSnartView.layer.cornerRadius = 5
        kommerSnartView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        kommerSnartView.alpha = 0.0
        popupLabel.text = "Denna funktion kommer snart."
        UIView.animate(withDuration: 0.6, animations: {
            self.kommerSnartView.alpha = 1
            self.kommerSnartView.transform = CGAffineTransform.identity
        })
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.kommerSnartView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.kommerSnartView.alpha = 0.0
        }) { (success: Bool) in
            self.kommerSnartView.removeFromSuperview()
        }
    }
    
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
                
                self.riksdagsArray.append(contentsOf: contentArray)
                self.refreshriksdagsFeedTableView()
            })
    }
    
    /////////////////////////////////////////////////////////
    
    func refreshriksdagsFeedTableView() {
        DispatchQueue.main.async {
            self.riksdagsFeedTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riksdagsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = riksdagsFeedTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        let info = riksdagsArray[indexPath.row]
        
        cell.parliamentInfo = info
        cell.didTappedReadMore = {
            DispatchQueue.main.async {
                self.riksdagsFeedTableView.beginUpdates()
                self.riksdagsFeedTableView.endUpdates()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetailedInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //showDetailedInfo
        
        if segue.identifier == "showDetailedInfo" {
            
            let index = riksdagsFeedTableView.indexPathForSelectedRow
            let row = index?.row
            let info = riksdagsArray[row!]
            let detailedVC = segue.destination as! DetailedInfoViewController
            detailedVC.rubrik = info.rubrik
            detailedVC.organ = info.organ
        }
    }
    
    
    // MARK: UIViewControllerPreviewingDelegate

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        guard let indexPath = self.riksdagsFeedTableView?.indexPathForRow(at: location) else { return nil }
        
        guard let cell = self.riksdagsFeedTableView?.cellForRow(at: indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailedInfoViewController else { return nil }
        
        let row = indexPath.row
        let info = riksdagsArray[row]
        detailVC.rubrik = info.rubrik
        detailVC.organ = info.organ
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        
    }

}
