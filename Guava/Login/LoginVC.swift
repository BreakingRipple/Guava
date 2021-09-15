//
//  LoginVC.swift
//  Guava
//
//  Created by Savage on 10/9/21.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy private var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(presentCodeLoginVC), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(loginBtn)
        setUI()
    }
    
    private func setUI(){
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    

}
