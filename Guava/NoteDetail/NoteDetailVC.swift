//
//  NoteDetailVC.swift
//  Guava
//
//  Created by Savage on 22/9/21.
//

import UIKit
import ImageSlideshow

class NoteDetailVC: UIViewController {
    
    
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        imageSlideshow.setImageInputs([
            ImageSource(image: UIImage(named: "15")!),
            ImageSource(image: UIImage(named: "16")!),
            ImageSource(image: UIImage(named: "17")!),
            ImageSource(image: UIImage(named: "18")!)
        ])
        
        let imageSize = UIImage(named: "15")!.size
        imageSlideShowHeight.constant = (imageSize.height / imageSize.width) * screenRect.width
        
        setUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView.frame = frame
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
