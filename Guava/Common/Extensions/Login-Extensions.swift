//
//  LoginVC-LocalLogin.swift
//  Guava
//
//  Created by Savage on 10/9/21.
//

import Foundation
import Alamofire

extension UIViewController{
    @objc func localLogin(){
        
        showLoadHUD()
        
        let config = JVAuthConfig()
        config.appKey = kJAppKey
        config.authBlock = { _ in
            if JVERIFICATIONService.isSetupClient(){
                JVERIFICATIONService.preLogin(5000) { (result) in
                    self.hideLoadHUD()
                    if let result = result, let code = result["code"] as? Int, code == 7000 {
                        // success to preLogin
                        self.setLocalLoginUI()
                        self.presentLocalLoginVC()
                    }else{
                        // unsupport click to login
                        print("Fail to preLogin. Failure code: \(result!["code"]), Failure description: \(result!["content"])")
                        self.presentCodeLoginVC()
                    }
                }
            }else{
                self.hideLoadHUD()
                print("fail to init")
                self.presentCodeLoginVC()
            }
        }
        JVERIFICATIONService.setup(with: config)
        
    }
    
    
    
    // MARK:
    private func presentLocalLoginVC(){
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5*1000, completion: { (result) in
            if let result = result, let loginToken = result["loginToken"] as? String {
                // success to login
                JVERIFICATIONService.clearPreLoginCache()
                
                
                
                
                
                print(loginToken)
                //                self.getEncryptedPhoneNum(loginToken)
            } else {
                print("fail to click to login")
                self.otherLogin()
            }
        }) { (type, content) in
            if let content = content {
                print("一键登录 actionBlock :type = \(type), content = \(content)")
            }
        }
    }
}

//MARK: - Listening
extension UIViewController{
    @objc func otherLogin(){
        JVERIFICATIONService.dismissLoginController(animated: true) {
            self.presentCodeLoginVC()
        }
        
    }
    
    @objc private func dismissLocalLoginVC(){
        JVERIFICATIONService.dismissLoginController(animated: true, completion: nil)
    }
}

//MARK: - Nomal function
extension UIViewController{
    @objc func presentCodeLoginVC(){
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let loginNaviC = mainSB.instantiateViewController(identifier: kLoginNavID)
        loginNaviC.modalPresentationStyle = .fullScreen
        present(loginNaviC, animated: true)
        
        //        (presentedViewController as! UINavigationController).pushViewController(loginNaviC, animated: true)
    }
}

//MARK: - UI
extension UIViewController{
    private func setLocalLoginUI(){
        let config = JVUIConfig()
        config.prefersStatusBarHidden = true
        config.navTransparent = true
        config.navText = NSAttributedString(string: " ")
        config.navReturnHidden = true
        config.navControl = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(dismissLocalLoginVC))
        
        let constraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)!
        
        
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/7, constant: 0)!
        config.logoConstraints = [constraintX, logoConstraintY]
        
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.numberConstraints = [constraintX, numberConstraintY]
        
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.sloganConstraints = [constraintX, sloganConstraintY]
        
        config.logBtnText = "Agree to login"
        config.logBtnImgs = [UIImage(named: "localLoginBtn-nor")!, UIImage(named: "localLoginBtn-nor")!, UIImage(named: "localLoginBtn-hig")!]
        
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)!
        config.logBtnConstraints = [constraintX, logBtnConstraintY]
        
        config.privacyState = true
        config.checkViewHidden = true
        
        config.appPrivacyOne = ["User agreement", "https://www.apple.com"]
        config.appPrivacyTwo = ["Privacy", "https://www.apple.com"]
        config.privacyComponents = ["login represents that you agree with this license", "and", "&", " "]
        config.appPrivacyColor = [UIColor.secondaryLabel, blueColor]
        config.privacyTextAlignment = .center
        
        let privacyConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)!
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)!
        config.privacyConstraints = [constraintX, privacyConstraintY, privacyConstraintW]
        
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")
        
        
        JVERIFICATIONService.customUI(with: config) { customView in
            guard let customView = customView else { return }
            
            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("other ways to login", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpOutside)
            customView.addSubview(otherLoginBtn)
            
            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 170),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
        }
    }
}


extension UIViewController{
    
    struct LocalLoginRes: Codable {
        let phone: String
    }
    
    private func getEncryptedPhoneNum(_ loginToken: String){
        let headers: HTTPHeaders = [
            .authorization(username: kJAppKey, password: "")
        ]
        
        let parameters = ["loginToken": loginToken]
        AF.request(
            "https://api.verification.jpush.cn/v1/web/loginTokenVerify",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).responseDecodable(of: LocalLoginRes.self) { response in
            if let localLoginRes = response.value{
                print(localLoginRes.phone)
            }
        }
        
        
    }
}

