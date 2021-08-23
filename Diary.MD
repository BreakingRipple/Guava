
### Add separate view controller into tab bar controller
        ctrl + tab bar controller       ---drag-->       separate view controller, select view controllers in relationship segue.

### Use cocoapods to install third party library
        pod -- version       // open terminal to check wheather the cocoapods has been installed
        sudo gem install cocoapods      //install cocoapods
        cd /Users/Savage/Documents/Swift/UIKit/SwiftWithLebus/实战项目-模拟小红书/石榴记/Guava      // change to root directory of the project
        pod init        //create "Podfile" & add "pod 'XLPagerTabStrip', '~> 9.0' " on this file
        pod install     //Analyzing dependencies & Downloading dependencies
            optional: pod repo update       // update the index file of cocoapods
    
### Use XLPagerTabStrip to develop TOP tab bar
        https://github.com/xmartlabs/XLPagerTabStrip
        
### WaterfallLayout - customized layout of Collectionview
        https://github.com/chiahsien/CHTCollectionViewWaterfallLayout
        
### Localizable including text image and App name
        1.[storyboard](Project)Guava --> Localizations --> click "+" --> select "Chinese simple" --> modify "Main.strings"。
        2.[file:manual] Guava --> create file "Localizable.strings" --> right section, Localization --> add language --> modify DiscoveryVC.swift "return IndicatorInfo(title: NSLocalizedString("Discovery", comment: "Discovery tab on the top of the Home page."))" --> open file "Localizable.strings" --> add translation entry.
        3.[file:automatic] delete file "Localizable.strings" --> on terminal: cd /Users/Savage/Documents/Swift/UIKit/SwiftWithLebus/实战项目-模拟小红书/石榴记/Guava/Guava --> genstrings -o zh-Hans.lproj *.swift --> genstrings -o zh-Hans.lproj Home/*.swift
        4.[display name] Guava --> create file "InfoPlist.strings" --> right section, Localization --> add language --> add translation entry.
        
### ImagePicker
        https://github.com/Yummypets/YPImagePicker
            
