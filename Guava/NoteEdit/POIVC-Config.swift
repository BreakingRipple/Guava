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
        
        
        
        
    }
}
