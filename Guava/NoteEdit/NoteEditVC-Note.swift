//
//  NoteEditVC-Note.swift
//  Guava
//
//  Created by Savage on 18/9/21.
//

import Foundation
import LeanCloud

extension NoteEditVC{
    func createNote(){
        do {
            let noteGroup = DispatchGroup()
            
            let note = LCObject(className: kNoteTable)
            
            if let videoURL = self.videoURL{
                let video = LCFile(payload: .fileURL(fileURL: videoURL))
                video.save(to: note, as: kVideoCol, group: noteGroup)
            }
            
            if let coverPhotoData = photos[0].jpeg(.high){
                let coverPhoto = LCFile(payload: .data(data: coverPhotoData))
//                coverPhoto.mimeType = "image/jpeg"
                coverPhoto.save(to: note, as: kCoverPhotoCol, group: noteGroup)
            }
            
            let photoGroup = DispatchGroup()
            var photoPaths: [Int:String] = [:]
            for (index, eachPhoto) in photos.enumerated(){
                if let photoData = eachPhoto.pngData(){
                    let photo = LCFile(payload: .data(data: photoData))
                    photoGroup.enter()
                    photo.save { res in
                        if case .success = res, let path = photo.url?.stringValue{
                            photoPaths[index] = path
                        }
                        photoGroup.leave()
                    }
                }
            }
            
            noteGroup.enter()
            photoGroup.notify(queue: .main) {
                let photoPathArr = photoPaths.sorted(by: <).map{$0.value}
                
                do{
                    try note.set(kPhotosCol, value: photoPathArr)
                    note.save { _ in
//                        print("fail/success to save photos")
                        noteGroup.leave()
                    }
                }catch{
                    print("fail")
                }
            }
            
        
            try note.set(kTitleCol, value: titleTextField.exactText)
            try note.set(kTextCol, value: textView.exactText)
            try note.set(kChannelCol, value: channel.isEmpty ? "For you" : channel)
            try note.set(kSubChannelCol, value: subChannel)
            try note.set(kPOINameCol, value: poiName)
            
            noteGroup.enter()
            note.save { res in
//                print("success/fail to store normal data")
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
//                print("all notes have been saved.")
                self.showTextHUD("post note successfully", false)
            }
            
            if draftNote != nil{
                navigationController?.popViewController(animated: true)
            }else{
                dismiss(animated: true)
            }
            
            dismiss(animated: true)
        } catch {
            print("fail to save note on cloud: \(error)")
        }
    }
    
    func postDraftNote(_ draftNote: DraftNote){
        createNote()
        
        backgroundContext.perform {
            //datasource
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            
        }
        
        //UI
        DispatchQueue.main.async {
            self.postDraftNoteFinished?()
        }
    }
}
