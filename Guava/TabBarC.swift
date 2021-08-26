//
//  TabBarC.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        //        if let vc = viewController as? PostVC {
        if viewController is PostVC {
            
            //to do(check login status of the user)
            
            var config = YPImagePickerConfiguration()
            
            //MARK: General
            config.isScrollToChangeModesEnabled = false
            config.onlySquareImagesFromCamera = false
            config.usesFrontCamera = true
            config.albumName = Bundle.main.appName
            config.startOnScreen = .library
            config.screens = [.library, .photo, .video]
            config.showsCrop = .none
            config.targetImageSize = YPImageSize.original
            config.hidesBottomBar = false
            config.hidesCancelButton = false
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = kMaxCameraZoomFactor
            
            //rules:
            //1. It is not allowed to mix photo with video, while multiple videos will be merge together.
            //2. No matter the photo is from library or just is taken newly,after then, we can append new photo on the edit page.
            //3. In conclusion, we just allow user to post only one video or multiple photos at the same time.
            
            //MARK: Library
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = kSpacingBetweenItems
            
            //MARK: Video
            
            //MARK: Gallery
            config.gallery.hidesRemoveButton = false

            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("user clicks the Cancel button")
                }
                
                for item in items {
                    switch item {
                    case let .photo(photo):
                        print(photo)
                    case .video(let video):
                        print(video)
                    }
                }
                
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        }
            
        return true
        
    }
    

}
