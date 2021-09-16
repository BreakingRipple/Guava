//
//  Login-Extensions.swift
//  Guava
//
//  Created by Savage on 16/9/21.
//

import LeanCloud

extension UIViewController{
    func configAfterLogin(_ user: LCUser, _ nickName: String, _ email: String = ""){
        if let _ = user.get(kNickNameCol){
            dismissAndShowMeVC()
        }else{//首次登录（即注册）
            let group = DispatchGroup()
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")
            
            if let avatarData = randomAvatar?.pngData(){
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                avatarFile.save(to: user, as: kAvatarCol, group: group)
            }
            
            do {
                if email != ""{
                    user.email = LCString(email)
                }
                
                try user.set(kNickNameCol, value: nickName)
                //                    user.save { (result) in
                //                        switch result {
                //                        case .success:
                //                            break
                //                        case .failure(error: let error):
                //                            print(error)
                //                        }
                //                    }
            } catch {
                print("fail to asign value \(error)")
                return
            }
            
            group.enter()
            user.save { result in
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.dismissAndShowMeVC()
            }
            
            
            
        }
        
        
    }
    
    func dismissAndShowMeVC(){
        hideLoadHUD()
        DispatchQueue.main.async {
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let meVC = mainSB.instantiateViewController(identifier: kMeVCID)
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child: meVC)
            
            self.dismiss(animated: true)
        }
        
    }
}
