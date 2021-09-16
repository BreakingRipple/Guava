//
//  LoginAndMeParentVC.swift
//  Guava
//
//  Created by Savage on 16/9/21.
//

import UIKit
import LeanCloud


var loginAndMeParentVC = UIViewController()
class LoginAndMeParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = LCApplication.default.currentUser {
            let meVC = storyboard!.instantiateViewController(withIdentifier: kMeVCID)
            add(child: meVC)
            print(user)
        } else {
            let loginVC = storyboard!.instantiateViewController(withIdentifier: kLoginVCID)
            add(child: loginVC)
        }
        
        loginAndMeParentVC = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
