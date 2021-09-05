//
//  NoteEditVC-DraftNote.swift
//  Guava
//
//  Created by Savage on 5/9/21.
//

extension NoteEditVC{
    func createDraftNote(){
        //running on background
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            //video
            if self.isVideo {
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            draftNote.isVideo = self.isVideo
            //photos
            self.handlePhotos(draftNote)
            //others
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUD("Save draft successfully!")
            }
        }
    }
    
    func updateDraftNote(_ draftNote: DraftNote){
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote)
            }
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension NoteEditVC{
    private func handlePhotos(_ draftNote: DraftNote){
        draftNote.coverPhoto = photos[0].jpeg(.high)
        var photos: [Data] = []
        for photo in self.photos{
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote){
        
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
    }
}
