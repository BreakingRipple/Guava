//
//  POIVC-Location.swift
//  Guava
//
//  Created by Savage on 1/9/21.
//



extension POIVC{
    func requestLocation(){
        
        showLoadHUD()
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            self?.hideLoadHUD()
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            if let location = location {
                print("location:", location)
            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
                
                //AMapLocationReGeocode:{formattedAddress:江苏省苏州市虎丘区狮山路靠近浙江大学现代远程教育苏州学习中心; country:中国;province:江苏省; city:苏州市; district:虎丘区; citycode:0512; adcode:320505; street:狮山路; number:66号; POIName:浙江大学现代远程教育苏州学习中心; AOIName:(null);}
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                
                let address = "\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"
                let currentPOI = [reGeocode.poiName!, address]
                self?.pois.append(currentPOI)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }
        })
    }
}
