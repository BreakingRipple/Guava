
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

### GCD (Grand Central Dispatch)
        1. tasks (code to be executed)
            1) sync: dont't have the ability to open up multiple threads
            2) async: enable to open up multiple threads
        2. queue (tasks in a queue waiting for being executed) -- FIFO
            1) Serial Dispatch Queue -- perform tasks in a queue sequentially
            2) Concurrent Dispatch Queue -- execute more than one task at the same time
            
            以10辆汽车在公路上行驶举例：
            每辆汽车代表一个任务，排队等候的汽车代表队列，公路代表线程，汽车从公路上通过代表任务执行。
            1) 串行队列同步执行： 10辆汽车排成一支长队，只有一条公路，故只能顺次通过
            2) 串行队列异步执行： 10辆汽车排成一支长队，有好几条公路，只能选择一条顺次通过
            3) 并发队列同步执行： 10辆汽车排成多支队伍，只有一条公路，故也只能顺次通过
            4) 并发队列异步执行： 10辆汽车排成多支队伍，有好几条公路，各队伍可同时通过
            
            日常开发中用到最多1和4两种。
            总结
            1）串行并行-汽车排了几队： 排一对的就像连成一串，为串行；排几队就是待会可以并行，为并行。
            2）同步异步-有几条公路：一条就只能顺次通过，为同步；好几条就可以同时通过，为异步。
            3）默认代码为串行同步，网络请求为并发异步。
            ------------------------------------------------------------------
            //举例1：创建一个串行队列，并给队列取一个名字
            let serialQueue = DispatchQueue(label: "serialQueue")
            //用这个队列同步执行一段代码
            serialQueue.sync {
                for i in 1...3{
                print("i:\(i)")
                }
            }
            //在队列外面执行其他代码
            for j in 10...13{
                print("j:\(j)")
            }
            //打印结果
            i:1
            i:2
            i:3
            j:10
            j:11
            j:12
            j:13

            //举例2：创建一个串行队列，并给队列取一个名字
            //创建一个并发队列
            let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
            //用这个并发队列异步执行一段代码
            concurrentQueue.async {
                for i in 1...3{
                    print("i:\(i)")
                }
            }
            //另外一个并发队列异步执行
            concurrentQueue.async {
                for j in 10...13{
                    print("j:\(j)")
                }
            }
            //打印结果
            j:10
            j:11
            j:12
            j:13
            i:1
            i:2
            i:3
            ------------------------------------------------------------------
            //特殊主线程
            DispatchQueue.main.async {
                <#code#>
            }
            //特殊并发队列 -- 全局并发队列
            DispatchQueue.global().async {
                print(Thread.current)
                //回到主线程
                DispatchQueue.main.async {
                    print(Thread.current)
                }
            }
            // load image from remote server
            lazy private var imageView: UIImageView = {
               let imageView = UIImageView(frame: CGRect(x: 16, y: 44, width: 300, height: 300))
                return imageView
            }()
            override func viewDidLoad() {
                super.viewDidLoad()
                view.addSubview(imageView)
            }
            DispatchQueue.global().async {
                print(Thread.current)
                print("第二个全局并发线程")
                let data = try! Data(contentsOf: URL(string: "https://user-images.githubusercontent.com/70803868/131475186-a11a9d71-d14e-450e-a789-c2545f15503b.png")!)
                let image = UIImage(data)!
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
            ------------------------------------------------------------------
            //主线程异步延迟执行
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: <#T##() -> Void#>)

### create objects by coding
        1. create a closure, set attributes
        lazy private var loginBtn: UIButton = {
            let btn = UIButton()
            btn.setTitle("Login", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = mainColor
            btn.layer.cornerRadius = 22
            btn.addTarget(self, action: #selector(localLogin), for: .touchUpInside)
            return btn
        }()
        2. set constraints
        view.addSubview(loginBtn)
        setUI()
        
        
### PopupDialog
        https://github.com/Orderella/PopupDialog
        https://github.com/huri000/SwiftEntryKit
