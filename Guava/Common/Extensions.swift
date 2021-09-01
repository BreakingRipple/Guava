//
//  Extensions.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit


extension UITextField{
    var unwrapperText: String{ text ?? ""}
}

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
    func showLoadHUD(_ title: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    
    func hideLoadHUD(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
    //MARK: Indicating view -- hide automatically
    func showTextHUD(_ title: String, _ subTitle: String? = nil){
        let hud =  MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text //if this is not set, the view will display flower and below two line labels.
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
    
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("failing to load \(type)")
    }
    
}
