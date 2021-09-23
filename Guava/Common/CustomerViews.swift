//
//  CustomerViews.swift
//  Guava
//
//  Created by Savage on 22/9/21.
//

import Foundation

@IBDesignable
class BigButton: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        shareInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shareInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        shareInit()
    }
    
    private func shareInit(){
        backgroundColor = .secondarySystemBackground
        tintColor = .placeholderText
        setTitleColor(.placeholderText, for: .normal)
        
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

@IBDesignable
class RoundedLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 5)))
    }
}
