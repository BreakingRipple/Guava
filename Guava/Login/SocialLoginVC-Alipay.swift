//
//  SocialLoginVC-Alipay.swift
//  Guava
//
//  Created by Savage on 14/9/21.
//

import Alamofire


extension SocialLoginVC{
    
    
    func signInWithAlipay(){
        
        let infoStr = "apiname=com.alipay.account.auth&app_id=\(kAliPayAppID)&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=\(kAliPayPID)&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20210914"
        guard let signer = APRSASigner(privateKey: kAliPayPrivateKey),
              let signedStr = signer.sign(infoStr, withRSA2: true) else { return }
        
        let authInfoStr = "\(infoStr)&sign=\(signedStr)"
        
        AlipaySDK.defaultService().auth_V2(withInfo: authInfoStr, fromScheme: kAppScheme) { res in
            guard let res = res else { return }
            
            let resStatus = res["resultStatus"] as! String
            
            if resStatus == "9000"{
                
                let resStr = res["result"] as! String
                
                let resArr = resStr.components(separatedBy: "&")
                
                for subResult in resArr{
                    let equalIndex = subResult.firstIndex(of: "=")!
                    let equalEndIndex = subResult.index(after: equalIndex)
                    //                    let prefix = subResult[..<equalIndex]
                    let suffix = subResult[equalEndIndex...]
                    //                    print(prefix)
                                        print(suffix)
                    
                    if subResult.hasPrefix("auth_code"){
//                        self.getToken(String(suffix))
                    }
                }
            }
        }
    }
}

extension SocialLoginVC{
    private func getToken(_ authCode: String) {
        //https://openapi.alipay.com/gateway.do?timestamp=2013-01-01 08:08:08&method=alipay.system.oauth.token&app_id=4472&sign_type=RSA2&sign=ERITJKEIJKJHKKKKKKKHJEREEEEEEEEEEE&version=1.0&charset=GBK&grant_type=authorization_code&code=4b203fe6c11548bcabd8da5bb087a83b
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.system.oauth.token",
            "app_id": kAliPayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "grant_type": "authorization_code",
            "code": authCode
        ]
        
        
        //                        print(parameters)
        
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters)).responseDecodable(of: TokenResponse.self) { response in
            if let tokenResponse = response.value{
                let accessToken = tokenResponse.alipay_system_oauth_token_response.access_token
                self.getInfo(accessToken)
            }
        }
        
    }
    
    private func getInfo(_ accessToken: String){
        //https://openapi.alipay.com/gateway.do?timestamp=2013-01-01 08:08:08&method=alipay.user.info.share&app_id=24257&sign_type=RSA2&sign=ERITJKEIJKJHKKKKKKKHJEREEEEEEEEEEE&version=1.0&charset=GBK&auth_token=20130319e9b8d53d09034da8998caefa756c4006
        //为确保安全通信，需自行验证响应示例中的sign值是否为支付宝开放平台所提供。
        
        let parameters = [
            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
            "method": "alipay.user.info.share",
            "app_id": kAliPayAppID,
            "sign_type": "RSA2",
            "version": "1.0",
            "charset": "utf-8",
            "auth_token": accessToken
        ]
        
        AF.request("https://openapi.alipay.com/gateway.do", parameters: self.signedParameters(parameters)).responseDecodable(of: InfoShareResponse.self ) { response in
            if let infoShareResponse = response.value{
                let info = infoShareResponse.alipay_user_info_share_response
                print(info)
                
                //                                        print(info.nick_name, info.avatar, info.gender)
                //                                        print(info.province, info.city)
            }
        }
    }
}

extension SocialLoginVC{
    private func signedParameters(_ parameters: [String:String]) -> [String:String]{
        
        var signedParameters = parameters
        let urlParameters = parameters.map{ "\($0)=\($1)"}.sorted().joined(separator: "&")
        
        guard let signer = APRSASigner(privateKey: kAliPayPrivateKey),
              let signedStr = signer.sign(urlParameters, withRSA2: true) else {
            fatalError("fail to sign")
        }
        
        signedParameters["sign"] = signedStr.removingPercentEncoding ?? signedStr
        
        return signedParameters
    }
}

extension SocialLoginVC{
    struct TokenResponse: Decodable {
        let alipay_system_oauth_token_response: TokenResponseInfo
        
        struct TokenResponseInfo: Decodable{
            let access_token: String
        }
    }
    
    struct InfoShareResponse: Decodable {
        let alipay_user_info_share_response: InfoShareResponseInfo
        
        struct InfoShareResponseInfo: Decodable {
            //            let avatar: String
            //            let nick_name: String
            //            let gender: String
            //            let province: String
            //            let city: String
            let code: String
            let msg: String
        }
    }
}
