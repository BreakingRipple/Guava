1. use cocoapods to install third party library
        pod -- version       // open terminal to check wheather the cocoapods has been installed
        sudo gem install cocoapods      //install cocoapods
        cd /Users/Savage/Documents/Swift/UIKit/SwiftWithLebus/实战项目-模拟小红书/石榴记/Guava      // change to root directory of the project
        pod init        //create "Podfile" & add "pod 'XLPagerTabStrip', '~> 9.0' " on this file
        pod install     //Analyzing dependencies & Downloading dependencies
            optional: pod repo update       // update the index file of cocoapods
        
