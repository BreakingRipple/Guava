//
//  WaterfallVC.swift
//  Guava
//
//  Created by Savage on 22/8/21.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

//private let reuseIdentifier = "Cell"

class WaterfallVC: UICollectionViewController {

    var channel = ""
    var draftNotes = [DraftNote]()
    var isMyDraft = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getDraftNotes()
        
//        layout.itemRenderDirection = .shortestFirst
//
//        //Uncomment the following line to preserve selection between presentations
//        self.clearsSelectionOnViewWillAppear = false
//
//        //Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    @IBAction func dismissDraftNotesVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
}

//MARK: CHTCollectionViewDelegateWaterfallLayout
extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isMyDraft{
            let cellW = (screenRect.width - kWaterfallPadding * 3) / 2
            var cellH: CGFloat = 0
            
            let draftNote = draftNotes[indexPath.item]
            let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
            let imageH = imageSize.height
            let imageW = imageSize.width
            let imageRatio = imageH / imageW
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewH
            
            return CGSize(width: cellW, height: cellH)
        }else{
            return UIImage(named: "\(indexPath.item + 1)")!.size
        }
    }
}

extension WaterfallVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
