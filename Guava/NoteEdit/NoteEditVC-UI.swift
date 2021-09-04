//
//  NoteEditVC-UI.swift
//  Guava
//
//  Created by Savage on 4/9/21.
//

extension NoteEditVC{
    func setUI(){
        setDraftNoteEditUI()
    }
       
}

//MARK: edit draft note
extension NoteEditVC{
    private func setDraftNoteEditUI(){
        if let draftNote = draftNote{
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty{
                updateChannelUI()
            }
            
            if !poiName.isEmpty{
                updatePOINameUI()
            }
        
        }
    }
    
    func updateChannelUI(){
        channelIcon.tintColor = blueColor
        channelLabel.text = subChannel
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
    }
    
    func updatePOINameUI(){
        if poiName == "" {
            poiNameIcon.tintColor = .label
            poiNameLabel.text = "add spot"
            poiNameLabel.textColor = .label
        }else{
            poiNameIcon.tintColor = blueColor
            poiNameLabel.text = poiName
            poiNameLabel.textColor = blueColor
        }
    }
}
