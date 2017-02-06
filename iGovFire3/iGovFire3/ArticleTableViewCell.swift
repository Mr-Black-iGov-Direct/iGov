//
//  CustomTableViewCell.swift
//  iGovFire3
//
//  Created by iGov Direct on 2016-11-03.
//  Copyright © 2016 iGov Direct. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.customReadMoreBtn.addTarget(self, action: #selector(ArticleTableViewCell.readMoreTap), for: UIControlEvents.touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var customRubrikLabel: UILabel!
    @IBOutlet weak var customOrganLabel: UILabel!
    @IBOutlet weak var customForslagTW: UITextView!
    @IBOutlet weak var customReadMoreBtn: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    var isExpanded: Bool = false
    
    var parliamentInfo: ParliamentInfo!
        {
        didSet {
            self.customRubrikLabel.text = self.parliamentInfo.rubrik
            self.customOrganLabel.text = "Förslag från: \(self.parliamentInfo.organ)"
            self.updateDetailLabel(true)
        }
    }
    
    var didTappedReadMore: (() -> ())?
    
    func updateDetailLabel(_ isTrimmed: Bool = false) {
        
        if let info = self.parliamentInfo {
            let replacedForslag = info.forslag.replacingOccurrences(of: "<BR/>", with: "\n")
            if isTrimmed {
                
                let forslag = replacedForslag
                let lastIndex = forslag.endIndex
                var trimIndex = forslag.index(forslag.startIndex, offsetBy: 30)
                if trimIndex > lastIndex {
                    trimIndex = lastIndex
                }
                self.detailLabel.text = replacedForslag.substring(to: trimIndex)
                
            } else {
                
                self.detailLabel.text = replacedForslag
            }
        }
    }
    
    func readMoreTap()
    {
        
        if(isExpanded){
            self.updateDetailLabel(true)
            self.customReadMoreBtn.setTitle("Read More".localized, for: UIControlState.normal)
        }else{
            self.updateDetailLabel()
            self.customReadMoreBtn.setTitle("Read Less".localized, for: UIControlState.normal)
        }
        if let closure = didTappedReadMore {
            closure()
        }
        self.isExpanded = !self.isExpanded
    }
    
    
}
