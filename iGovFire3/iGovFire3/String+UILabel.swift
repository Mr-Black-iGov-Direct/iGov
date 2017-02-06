//
//  String+UILabel.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-25.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
