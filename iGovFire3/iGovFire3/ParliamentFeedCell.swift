//
//  ParliamentFeedCell.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import UIKit

class ParliamentFeedCell: UITableViewCell
{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
