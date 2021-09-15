//
//  CodeLoginVC.swift
//  Guava
//
//  Created by Savage on 15/9/21.
//

import UIKit
import LeanCloud

private let totalTime = 6

class CodeLoginVC: UIViewController {

    private var timeRemain = totalTime
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    lazy private var timer = Timer()
    
    private var phoneNumStr: String { phoneNumTF.unwrapperText }
    private var authCodeStr: String { authCodeTF.unwrapperText }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.setToDisabled()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumTF.becomeFirstResponder()
    }
    
    @IBAction func dismiss(_ sender: Any) { dismiss(animated: true) }
    
    
    @IBAction func TFEditingChanged(_ sender: UITextField) {
        
        if sender == phoneNumTF{
            getAuthCodeBtn.isHidden = !phoneNumStr.isChinaMainlandPhoneNum && getAuthCodeBtn.isEnabled
        }
        
        if phoneNumStr.isChinaMainlandPhoneNum && authCodeStr.isAuthCode{
            loginBtn.setToEnable()
        }else{
            loginBtn.setToDisabled()
        }
        
    }
    
    
    
    @IBAction func getAuthCode(_ sender: Any) {
        getAuthCodeBtn.isEnabled = false
        setAuthCodeBtnDisabledText()
        authCodeTF.becomeFirstResponder()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeAuthCodeBtnText), userInfo: nil, repeats: true)
        
        let variables: LCDictionary = ["name": LCString("石头记Guava"), "ttl": LCNumber(5)]

        LCSMSClient.requestShortMessage(
            mobilePhoneNumber: phoneNumStr,
            templateName: "Order_Notice",
            signatureName: "sign_BuyBuyBuy",
            variables: variables)
        { result in
//            switch result {
//            case .success:
//                break
//            case .failure(error: let error):
//                print(error)
//            }
            if case let .failure(error: error) = result{
                print(error.reason)
            }
        }
        
    }
    
    @IBAction func login(_ sender: UIButton) {
    }

}

extension CodeLoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let limit = textField == phoneNumTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrapperText.count + string.count) > limit
       
        if isExceed{
            showTextHUD("no more than \(limit) digits")
        }
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumTF{
            authCodeTF.becomeFirstResponder()
        }else{
            if loginBtn.isEnabled{
                login(loginBtn)
            }
        }
        
        
        return true
    }
}

extension CodeLoginVC{
    @objc private func changeAuthCodeBtnText(){
        timeRemain -= 1
        setAuthCodeBtnDisabledText()
        
        if timeRemain <= 0{
            timer.invalidate()
            timeRemain = totalTime
            getAuthCodeBtn.isEnabled = true
            getAuthCodeBtn.setTitle("Get Code", for: .normal)
            
            getAuthCodeBtn.isHidden = !phoneNumStr.isChinaMainlandPhoneNum
        }
    }
}

extension CodeLoginVC{
    private func setAuthCodeBtnDisabledText(){
        getAuthCodeBtn.setTitle("resent(\(timeRemain)s)", for: .disabled)
    }
}
