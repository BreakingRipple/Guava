//
//  NoteEditVC-Config.swift
//  Guava
//
//  Created by Savage on 30/8/21.
//

import Foundation

extension NoteEditVC{
    func config(){
        photoCollectionView.dragInteractionEnabled = true
        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        
        textView.typingAttributes = typingAttributes
        //cursor color
        textView.tintColorDidChange()
        
        //soft keyboard view
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCountLabel.text = "/\(kMaxNoteTextCount)"
        
        locationManager.requestWhenInUseAuthorization()
        
    }
}

//MARK: listening
extension NoteEditVC{
    @objc private func resignTextView(){
        textView.resignFirstResponder()
    }
}
