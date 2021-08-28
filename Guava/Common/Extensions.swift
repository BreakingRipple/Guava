//
//  Extensions.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit

extension UIView{
    @IBInspectable
    var radius: CGFloat{
        get{
            layer.cornerRadius
        }
        
        set{
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController{
    
    //MARK: Display loading view and indicating view
    
    //MARK: Loading view -- hide manually
    
    //MARK: Indicating view -- hide automatically
    func showTextHUD(_ title: String, _ subTitle: String? = nil){
        let hud =  MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text //if this is not set, the view will display flower and below two line labels.
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
}

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
