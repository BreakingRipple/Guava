//
//  Extensions.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import Foundation

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
