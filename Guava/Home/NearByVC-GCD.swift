//
//  NearByVC.swift
//  Guava
//
//  Created by Savage on 21/8/21.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //MARK: DispatchGroup
        let group = DispatchGroup()
        
        group.enter()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            print("1")
            
            group.enter()
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                print("2")
                group.leave()
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("3")
        }
        
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("NearBy", comment: "NearBy tab on the top of the Home page."))
    }

}
