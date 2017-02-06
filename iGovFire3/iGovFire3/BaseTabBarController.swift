//
//  BaseTabBarController.swift
//  iGovFire3
//
//  Created by Lam Si Mon on 17-01-23.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController , UITabBarControllerDelegate
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViewControllers()
        self.setupTabBarAppearance()
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func setupViewControllers()
    {
        let mainViewController = MainViewController()
        let mainNav = UINavigationController.init(rootViewController: mainViewController) as UIViewController
        self.setupTabBarItem(controller: mainViewController)

        let ideaViewController = IdeaViewController()
        let ideaNav = UINavigationController.init(rootViewController: ideaViewController) as UIViewController
        self.setupTabBarItem(controller: ideaViewController)
        
        let budgetViewController = BudgetViewController()
        let budgetNav = UINavigationController.init(rootViewController: budgetViewController) as UIViewController
        self.setupTabBarItem(controller: budgetViewController)

        let lawViewController = LawViewController()
        let lawNav = UINavigationController.init(rootViewController: lawViewController) as UIViewController
        self.setupTabBarItem(controller: lawViewController)

        let settingsViewController = SettingsViewController()
        let settingsNav = UINavigationController.init(rootViewController: settingsViewController) as UIViewController
        self.setupTabBarItem(controller: settingsViewController)

        self.viewControllers = [mainNav,ideaNav,budgetNav,lawNav,settingsNav]
    }
    
    
    func setupTabBarItem(controller:UIViewController)
    {
        let item = UITabBarItem()
        
        if controller is MainViewController
        {
            item.image = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.title = "Förslag"
        }
        else if controller is IdeaViewController
        {
            item.image = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.title = "Ide"
        }
        else if controller is BudgetViewController
        {
            item.image = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.title = "Budget"
        }
        else if controller is LawViewController
        {
            item.image = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.title = "Lagar"
        }
        else if controller is SettingsViewController
        {
            item.image = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: "riksdagen-logo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.title = "Inställningar"
        }

        controller.tabBarItem = item;
    }
    
    
    func setupTabBarAppearance()
    {
        self.tabBar.isTranslucent = true
        self.tabBar.isOpaque = true
        
        let appearance = [NSForegroundColorAttributeName : UIColor.white]
        let appearanceSelected = [NSForegroundColorAttributeName : UIColor.navigationBarBackgroundColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes(appearance, for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes(appearanceSelected, for: UIControlState.selected)
    }
}
