//
//  NoteEditVC-DragDrop.swift
//  Guava
//
//  Created by Savage on 29/8/21.
//

import Foundation


extension NoteEditVC: UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
       
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photo))
        dragItem.localObject = photo
        
        return [dragItem]
    }
    
    // drag more than one item, implement "itemForAddingTo" method
    // change the appearance of cell when draging, implement "dragPreviewParametersForItemAt" method
    
}

extension NoteEditVC: UICollectionViewDropDelegate{
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        // to implement the function that user can't drag a cell in different secions, firstly create a global variable "dragingIndexpath", then assign "indexPath" to it in the "itemForBeginning" session, lastly compare "dragingIndexpath.section == destinationIndexPath.section"
      
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        coordinator.destinationIndexPath
        
        if coordinator.proposal.operation == .move,
           let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath,
           let destinationIndexPath = coordinator.destinationIndexPath{
            
            collectionView.performBatchUpdates {
                photos.remove(at: sourceIndexPath.item)
                photos.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }

            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    
}
