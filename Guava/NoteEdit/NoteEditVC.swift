//
//  NoteEditVC.swift
//  Guava
//
//  Created by Savage on 26/8/21.
//

import UIKit

class NoteEditVC: UIViewController {
    
    var draftNote: DraftNote?
    
    var updateDraftNoteFinished: (() -> ())?
    
    var photos = [
        UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "25")!
    ]
    
//    var videoURL: URL? = Bundle.main.url(forResource: "TV", withExtension: "mp4")
    var videoURL: URL?
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    @IBOutlet weak var poiNameIcon: UIImageView!
    @IBOutlet weak var poiNameLabel: UILabel!
    
    var photoCount: Int { photos.count }
    var isVideo: Bool { videoURL != nil }
    var textViewIAView: TextViewIAView{ textView.inputAccessoryView as! TextViewIAView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()
        
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
        handleTFEditChange()
    }
    
    // need to do draft
    @IBAction func saveDraftNote(_ sender: Any) {
        guard isValidateNote() else {
            return
        }
        
        if let draftNote = draftNote{
            updateDraftNote(draftNote)
        }else{
            createDraftNote()
        }
        
    }
    
    @IBAction func postNote(_ sender: Any) {
        guard isValidateNote() else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC{
            view.endEditing(true)
            channelVC.PVdelegate = self
        }else if let poiVC = segue.destination as? POIVC{
            poiVC.delegate = self
            poiVC.poiName = poiName
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
        updateChannelUI()
    }
}

extension NoteEditVC: POIVCDelegate{
    func updatePOIName(_ poiName: String) {
        
        //datasource
        if poiName == kPOIsInitArr[0][0]{
            self.poiName = ""
        }else{
            self.poiName = poiName
        }
        
        //UI
        updatePOINameUI()
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

