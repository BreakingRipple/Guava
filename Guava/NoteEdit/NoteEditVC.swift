//
//  NoteEditVC.swift
//  Guava
//
//  Created by Savage on 26/8/21.
//

import UIKit

class NoteEditVC: UIViewController {
    
    var photos = [
        UIImage(named: "25")!, UIImage(named: "26")!
    ]
//    var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: "mp4")!
    var videoURL: URL?
    
    var channel = ""
    var subChannel = ""

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    
    
    var photoCount: Int { photos.count }
    var isVideo: Bool { videoURL != nil }
    var textViewIAView: TextViewIAView{ textView.inputAccessoryView as! TextViewIAView }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()

    }

    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    
    @IBAction func TFEndOnExit(_ sender: Any) {
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
//        guard titleTextField.markedTextRange == nil else { return }
//        if titleTextField.unwrapperText.count > kMaxNoteTitleCount{
//            titleTextField.text = String(titleTextField.unwrapperText.prefix(kMaxNoteTitleCount))
//            showTextHUD("no more than \(kMaxNoteTitleCount) characters")
//            DispatchQueue.main.async {
//                let end = self.titleTextField.endOfDocument
//                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
//            }
//        }
        
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrapperText.count)"
    }
    
    // need to do draft
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC{
            channelVC.PVdelegate = self
        }
    }
    
}

extension NoteEditVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        textViewIAView.currentTextCount = textView.text.count
    }
}

extension NoteEditVC: ChannelVCDelegate{
    func updateChannel(channel: String, subChannel: String) {
        //datasource
        self.channel = channel
        self.subChannel = subChannel
        
        //UI
        channelLabel.text = subChannel
        channelIcon.tintColor = blueColor
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
        
    }
}

extension NoteEditVC: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        // 1:
//        print(range.location)
//        print(string)
//        if range.location >= kMaxNoteTitleCount || (textField.unwrapperText.count + string.count) > kMaxNoteTitleCount {
//            return false
//        }
//
//        let isExceed = range.location >= kMaxNoteTitleCount || (textField.unwrapperText.count + string.count) > kMaxNoteTitleCount
//
//        if isExceed{
//            showTextHUD("total character count is no more than \(kMaxNoteTitleCount)")
//        }
//        return !isExceed
        
        
        // 2:
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        if updatedText.count <= kMaxNoteTitleCount {
            return true
        } else {
            showTextHUD("no more than \(kMaxNoteTitleCount) characters")
            return false
        }
        
    }
    
}

