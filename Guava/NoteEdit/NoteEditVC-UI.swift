//
//  NoteEditVC-UI.swift
//  Guava
//
//  Created by Savage on 4/9/21.
//

import PopupDialog

extension NoteEditVC{
    func setUI(){
        
        addPopup()
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

extension NoteEditVC{
    private func addPopup(){
        let icon = largeIcon("info.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showPopup))
        
        let pv = PopupDialogDefaultView.appearance()
        pv.titleColor = .label
        pv.messageFont = .systemFont(ofSize: 13)
        pv.messageColor = .secondaryLabel
        pv.messageTextAlignment = .natural
        
        let cb = CancelButton.appearance()
        cb.titleColor = .label
        cb.separatorColor = mainColor
        
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = .secondarySystemBackground
        pcv.cornerRadius = 10
    }
}

extension NoteEditVC{
    @objc private func showPopup(){
        let title = "Tips"
        let message =
            """
            小石榴鼓励向上，真实，原创的内容，含以下内容的笔记将不被推荐：
            1.含有不良语言，过度性感图片；
            2.含有网址链接，联系方式，二维码或售卖语言；
            3.冒充他人身份或搬运他人作品；
            4.通过有奖方式诱导他人点赞，评论，收藏，转发，关注。
            """
        let popup = PopupDialog(title: title, message: message, transitionStyle: .zoomIn)
        let btn = CancelButton(title: "OK", action: nil)
        popup.addButton(btn)
        present(popup, animated: true)
    }
}
