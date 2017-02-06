//
//  UINavigationController+NavigationBar.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController
{
    class func navigationBarDemocracyLogo() -> UIImageView
    {
        var navigationTitleImage : UIImage?
        
        #if SWEDEN
            navigationTitleImage = #imageLiteral(resourceName: "direktdemokraterna-logo")
        #elseif NORWAY
            navigationTitleImage = #imageLiteral(resourceName: "direktdemokraterna-logo")
        #endif
     
        let imageView = UIImageView.init(image: navigationTitleImage)
        
        return imageView
    }
}
