//
//  TabBarC.swift
//  Guava
//
//  Created by Savage on 23/8/21.
//

import UIKit
import YPImagePicker
import LeanCloud

class TabBarC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        //        if let vc = viewController as? PostVC {
        if viewController is PostVC {
            
            //to do(check login status of the user)
            if let _  = LCApplication.default.currentUser{
                var config = YPImagePickerConfiguration()
                
                //MARK: General
                config.isScrollToChangeModesEnabled = false
                config.onlySquareImagesFromCamera = false
                config.usesFrontCamera = true
                config.albumName = Bundle.main.appName
                config.startOnScreen = .library
                config.screens = [.library, .photo, .video]
                config.showsCrop = .rectangle(ratio: 0.8)
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
                        picker.dismiss(animated: true)
                    }else{
                            
                        var photos: [UIImage] = []
                        var videoURL: URL?
                        for item in items {
                            switch item {
                            case let .photo(photo):
                                photos.append(photo.image)
                            case .video(let video):
                                
    //                            let url = URL(fileURLWithPath: "recordedVideoRAW.mov", relativeTo: FileManager.default.temporaryDirectory)
    //                            photos.append(video.thumbnail)
    //                            videoURL = url
                                
                                photos.append(video.thumbnail)
                                videoURL = video.url
                            }
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                        vc.photos = photos
                        vc.videoURL = videoURL
                        
                        picker.pushViewController(vc, animated: true)
                    }
                }
                present(picker, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Notice", message: "need to login first", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "continue looking around", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "go to login", style: .default, handler: { _ in
                    tabBarController.selectedIndex = 4
                }))
                
                present(alert, animated: true, completion: nil)
            }
            
            return false
        }
            
        return true
        
    }
    

}
