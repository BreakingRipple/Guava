//
//  DiscoveryVC.swift
//  Guava
//
//  Created by Savage on 21/8/21.
//

import UIKit
import XLPagerTabStrip

class DiscoveryVC: UIViewController, IndicatorInfoProvider {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Discovery")
    }

}
