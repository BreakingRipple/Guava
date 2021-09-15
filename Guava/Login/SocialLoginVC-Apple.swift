//
//  SocialLoginVC-Apple.swift
//  Guava
//
//  Created by Savage on 15/9/21.
//
import AuthenticationServices

extension SocialLoginVC: ASAuthorizationControllerDelegate{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            print(userID)
//            print(appleIDCredential.fullName?.familyName)
//            print(appleIDCredential.fullName?.givenName)
//            print(appleIDCredential.email)
            var name = ""
            if appleIDCredential.fullName?.familyName != nil || appleIDCredential.fullName?.givenName != nil{
                let familyName = appleIDCredential.fullName?.familyName ?? ""
                let givenName = appleIDCredential.fullName?.givenName ?? ""
                name = "\(familyName) \(givenName)"
                UserDefaults.standard.setValue(name, forKey: kNameFromAppleID)
            }else{
                name = UserDefaults.standard.string(forKey: kNameFromAppleID) ?? ""
            }
            print(name)
        
            var email = ""
            if let unwrappedEmail = appleIDCredential.email {
                email = unwrappedEmail
                UserDefaults.standard.setValue(email, forKey: kEmailFromAppleID)
            }else{
                email = UserDefaults.standard.string(forKey: kEmailFromAppleID) ?? ""
            }
            print(email)
            
            guard let identityToken = appleIDCredential.identityToken,
                  let authorizationCode = appleIDCredential.authorizationCode else { return }
            
            print(String(decoding: identityToken, as: UTF8.self))
            print(String(decoding: authorizationCode, as: UTF8.self))
            
        case let passwordCredential as ASPasswordCredential:
            let _ = passwordCredential.password
            let _ = passwordCredential.user
            print(passwordCredential)
        default:
            break
        }
        
        
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("fail to login with apple antuhorization service")
    }
}

extension SocialLoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor { view.window! }
}


extension SocialLoginVC{
    func checkSignInWithAppleState(with userID: String){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
            switch credentialState{
            case .authorized:
                print("user has logged in, display normal UI")
            case .revoked:
                print("user has logged out from settings")
            case .notFound:
                print("user not found")
            default:
                break
            }
        }
    }
}
