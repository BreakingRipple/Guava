//
//  MeVC.swift
//  Guava
//
//  Created by Savage on 5/9/21.
//

import UIKit
import LeanCloud

class MeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
//        navigationController?.navigationBar.tintColor = .label
    }
    

    @IBAction func logoutTestBtn(_ sender: Any) {
        
        LCUser.logOut()

        let loginVC = storyboard!.instantiateViewController(withIdentifier: kLoginVCID)
        loginAndMeParentVC.removeChildren()
        loginAndMeParentVC.add(child: loginVC)
        
    }
    

}
