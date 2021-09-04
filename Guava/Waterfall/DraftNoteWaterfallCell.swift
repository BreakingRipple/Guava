//
//  DraftNoteWaterfallCell.swift
//  Guava
//
//  Created by Savage on 3/9/21.
//

import UIKit

class DraftNoteWaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    
    var draftNote: DraftNote? {
        didSet{
            guard let draftNote = draftNote else { return}
            
            imageView.image = UIImage(draftNote.coverPhoto) ?? imagePH
            
            let title = draftNote.title!
            titleLabel.text = title.isEmpty ? "No title" : title
            
            dateLabel.text = draftNote.updatedAt?.formattedDate
            
            isVideoImageView.isHidden = !draftNote.isVideo
            
            
        }
    }
}
