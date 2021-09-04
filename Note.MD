
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
        
### MBProgressHUD  (using Objective-C library in our Swift project)
        https://github.com/jdg/MBProgressHUD
        1. Add a pod entry for MBProgressHUD to your Podfile pod 'MBProgressHUD', '~> 1.2.0'
        2. Install the pod(s) by running pod install.
        3. [manually create bridging header file] create new file "Guava-Bridging-Header.h" --> Guava  -->  TARGETS  -->  Objective-C Briding Header --> add address --> open fiel "Guava-Bridging-Header.h" --> add: #import "MBProgressHUD.h"
        4. OR [automatically create bridging header file]

### SKPhotoBrowser
        https://github.com/suzuki-0000/SKPhotoBrowser

### CollectionView Drag and Drop

### TextField Label and Text View

### Three ways to dismiss keyboard
        1. dismiss on drag (keyboardDismissMode)
        2. click the "finish" button on the user keyboard  (textField has a attibute called "text input traits" --> keyboard type; use the method in delegate: textFieldShouldReturn)  OR  @IBAction func TFEndOnExit(_ sender: Any) { }
        3. click blank space to dismiss keyboard

### UITextView + placeholder : KMPlaceholderTextView
        1. https://github.com/MoZhouqi/KMPlaceholderTextView

### Hash tag

### Location / POI: point of infomation 
        1. https://lbs.amap.com/

### Drop-down Refresh & Pull to Refresh
        1. https://github.com/CoderMJLee/MJRefresh

### Core Data
        1. Create entity(table in DB) in "Guava.xcdatamodeld"
        2. add attribute
        3. sort & select

### Date
        1. https://github.com/MatthewYork/DateTools
        
### Three ways to jump from one page to another
        1. tab bar 
        2. navigation controller (push)  
        3. present

### map( )

### pass value
        1. delegate
        2. closure  "var updateDraftNoteFinished: (() -> ())?"
