//
//  WaterfallVC-DataSource.swift
//  Guava
//
//  Created by Savage on 4/9/21.
//

import Foundation

extension WaterfallVC{
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isMyDraft{
            return draftNotes.count
        } else {
            return 35
        }
    
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isMyDraft {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterfallCellID, for: indexPath) as! DraftNoteWaterfallCell
            cell.draftNote = draftNotes[indexPath.item]
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterfallCellID, for: indexPath) as! WaterfallCell
            cell.imageView.image = UIImage(named: "\(indexPath.item + 1)")
            return cell
        }
        
    }
}

//MARK: Normal function
extension WaterfallVC{
    private func deleteDraftNote(_ index: Int){
        backgroundContext.perform {
            //datasource
            let draftNote = self.draftNotes[index]
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            
            self.draftNotes.remove(at: index)
        }
        
        //UI
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.showTextHUD("Delete draft successfully!")
        }
        
        
//        DispatchQueue.main.async {
//            self.collectionView.performBatchUpdates {
//                self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
//            }
//            self.showTextHUD("Delete draft note successfully.")
//        }
        
    }
}

//MARK: Listening
extension WaterfallVC{
    @objc private func showAlert(_ sender: UIButton){
//        print(sender.tag)
        let index = sender.tag
        
        let alert = UIAlertController(title: "Reminder", message: "Do you confirm to delete this draft note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction( UIAlertAction(title: "Confirm", style: .destructive){ _ in self.deleteDraftNote(index)} )
        
        present(alert, animated: true)
    }
}
