//
//  NoteEditVC-Helper.swift
//  Guava
//
//  Created by Savage on 4/9/21.
//

import Foundation

extension NoteEditVC{
    func isValidateNote() -> Bool{
        
        guard !photos.isEmpty else {
            showTextHUD("At least one pohto")
            return false
        }
        
        guard textViewIAView.currentTextCount <= kMaxNoteTextCount else {
            showTextHUD("No more than \(kMaxNoteTextCount) words.")
            return false
        }
        
        return true
    }
    
    func handleTFEditChange(){
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrapperText.count > kMaxNoteTitleCount{
            titleTextField.text = String(titleTextField.unwrapperText.prefix(kMaxNoteTitleCount))
            showTextHUD("no more than \(kMaxNoteTitleCount) characters")
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrapperText.count)"
    }
}
