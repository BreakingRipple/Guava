//
//  Extensions.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit
import DateToolsSwift

extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String{
    var unwrapperText: String{ self ?? ""}
}

extension Date{
    //date
    //1. just now /within 5 minutes; 2. today 21:10:03; 3. yesterday 21:10:03 4. 09-15; 5. 2019-09-01
    var formattedDate: String{
        let currentYear = Date().year
        
        if self.year == currentYear{
            
            if isToday{
                if minutesAgo > 10{
                    return "today \(format(with: "HH:mm"))"
                }else{
                    return timeAgoSinceNow
                }
                
            }else if isYesterday{
                return "yesterday \(format(with: "HH:mm"))"
            }else{
                return format(with: "MM-dd")
            }
            
        }else if year < currentYear{
            return format(with: "yyyy-MM-dd")
        }else{
            return "future"
        }
    }
}

extension UIImage{
    // 指定构造器必须调用它直接父类的指定构造方法
    // 便利构造器必须调用同一个类中定义的其他初始方法
    // 便利构造器在最后必须调用一个指定构造器
    convenience init?(_ data: Data?){
        if let unwrappedData = data{
            self.init(data: unwrappedData)
        }else{
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data?{
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UITextField{
    var unwrapperText: String{ text ?? ""}
    var exactText: String{
        unwrapperText.isBlank ? "" : unwrapperText
    }
}

extension UITextView{
    var unwrapperText: String{ text ?? ""}
    var exactText: String{
        unwrapperText.isBlank ? "" : unwrapperText
    }
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
