//
//  DetailedInfoViewController.swift
//  iGovFire3
//
//  Created by iGov Direct on 2016-11-06.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import UIKit

class DetailedInfoViewController: UIViewController {
    
    /////////////////////
    var rubrik: String = ""
    var organ: String = ""
    /////////////////////
    @IBOutlet weak var organLabel: UILabel!
    @IBOutlet weak var rubrikLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        organLabel.text = organ
        rubrikLabel.text = rubrik
        //print("Detailed info: \(rubrik)")
        //print("Detailed info: \(organ)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
