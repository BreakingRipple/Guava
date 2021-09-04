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
        
        // request permission 
        locationManager.requestWhenInUseAuthorization()
        
        //        //MARK: related to file
        //        // sandbox root directory
                print(NSHomeDirectory())
        //        print(NSTemporaryDirectory())
        //        // first method to find a file: return PATH (common string)
        //        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        //        // secode method to find a file: return URL (resource file)
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        //        // two examples of url
        //        file:///xxx/xx.mov (local url)
        //        https://xxx//xx.mov (remote url)
        
        //        do {
        //            try FileManager.default.removeItem(atPath: "\(NSHomeDirectory())/Library/SplashBoard")
        //        } catch {
        //            print(error)
        //        }
        
    }
}

//MARK: listening
extension NoteEditVC{
    @objc private func resignTextView(){
        textView.resignFirstResponder()
    }
}
