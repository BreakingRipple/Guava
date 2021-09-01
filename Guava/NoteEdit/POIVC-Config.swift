//
//  POIVC-Config.swift
//  Guava
//
//  Created by Savage on 1/9/21.
//


extension POIVC{
    func config(){
        
        //locate position
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5
        
        mapSearch?.delegate = self
        
        tableView.mj_footer = footer

        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
    }
}
