//
//  UIColor+NavigationBar.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func navigationBarBackgroundColor() -> UIColor
    {
        var backgroundColor : UIColor?
        
        #if SWEDEN
            backgroundColor = UIColor(red: 248.0/255.0, green: 140.0/255.0, blue: 0/255.0, alpha: 1.0)
        #elseif NORWAY
            backgroundColor = UIColor.blue
        #endif
        
        return backgroundColor!
    }
}
