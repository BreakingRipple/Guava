//
//  PhotoFooter.swift
//  Guava
//
//  Created by Savage on 27/8/21.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
}
