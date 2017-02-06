//
//  FeedDetailViewController.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController
{
    var feedTitle   : String = "" //Rubrik
    var feedDesc    : String = "" //Organ
    var feedProposed : String = "" //Forslag
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var proprosedLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupPage()
        self.edgesForExtendedLayout = []
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupPage() -> Void
    {
        self.titleLbl.text = self.feedTitle
        self.descLbl.text = "Förslag från: \(self.feedDesc)"
        
        self.feedProposed = self.feedProposed.replacingOccurrences(of: "<BR/>", with: "")
        self.proprosedLbl.text = self.feedProposed
     
        let height = self.proprosedLbl.text?.heightWithConstrainedWidth(width: self.proprosedLbl.frame.size.width, font: self.proprosedLbl.font)
        self.proprosedLbl.frame = CGRect(x: self.proprosedLbl.frame.origin.x, y: self.proprosedLbl.frame.origin.y, width: self.proprosedLbl.frame.size.width, height: height! + 90)
    }
}
