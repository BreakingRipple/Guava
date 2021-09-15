//
//  Extensions.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit
import DateToolsSwift
import AVFoundation

extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isChinaMainlandPhoneNum: Bool{
        Int(self) != nil && NSRegularExpression(kChinaPhoneRegEx).matches(self)
    }
    
    var isAuthCode: Bool{
        Int(self) != nil && NSRegularExpression(kAuthCodeRegEx).matches(self)
    }
}

extension NSRegularExpression{
    convenience init(_ pattern: String){
        do {
            try self.init(pattern: pattern)
        } catch {
            fatalError("invalid RecgEx")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
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

//给视频生成一个封面
extension URL{
    var thumbnail: UIImage{
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //如果视频尺寸确定的话可以用下面这句提高处理性能
        //assetImgGenerate.maximumSize = CGSize(width, height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return imagePH
        }
    }
}

extension UIButton{
    func setToEnable(){
        isEnabled = true
        backgroundColor = mainColor
    }
    
    func setToDisabled(){
        isEnabled = false
        backgroundColor = mainLightColor
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
    
    
    //MARK: Reminder view -- hide automatically
    func showTextHUD(_ title: String, _ inCurrentView: Bool = true, _ subTitle: String? = nil){
        var viewToShow = view!
        if !inCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud =  MBProgressHUD.showAdded(to: viewToShow, animated: true)
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

extension FileManager{
    func save(_ data: Data?, to dirName: String, as fileName: String) -> URL?{
        guard let data = data else {
//            print("no data to write.")
            return nil
        }
        
        // "file://xx/xx/tmp/dirName"
        // temporaryDirectory == URL(fileURLWithPath: NSTemporaryDirectory())
        // PATH -> URL
        let dirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(dirName, isDirectory: true)
        
        // URL -> PATH
        if !fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true) else {
                print("fail to create a directory.")
                return nil
            }
            
        }
        
        // "file://xx/xx/tmp/dirName/fileName"
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !fileExists(atPath: fileURL.path){
            guard let _ = try? data.write(to: fileURL) else {
                print("fail to save file.")
                return nil
            }
        }
        
        return fileURL
    }
}
