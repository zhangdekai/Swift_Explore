//
//  LocationManager.swift
//  RXSwift_Explore
//
//  Created by Dekai on 2020/11/9.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    
    static let shared = LocationManager()
    
    var getLocationHandle: ((_ success: Bool, _ latitude: Double, _ longitude: Double) -> Void)?
    
    var getAuthHandle: ((_ success: Bool) -> Void)?
    
    private var locationManager: CLLocationManager!
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.delegate = self
        
    }
    /// 设备是否开启了定位服务
    func hasLocationService() -> Bool {
        
        return CLLocationManager.locationServicesEnabled()
        
    }
    /// APP是否有定位权限
    func hasLocationPermission() -> Bool {
        
        if #available(iOS 14.0, *) {
            let status: CLAuthorizationStatus = locationManager.authorizationStatus
            print("location authorizationStatus is \(status.rawValue)")
            switch  status {
            case .notDetermined, .restricted, .denied:
                
                return false
                
            case .authorizedWhenInUse, .authorizedAlways:
                
                return true
            default:
                break
            }
            
        } else {
            let status = CLLocationManager.authorizationStatus()
            print("location authorizationStatus is \(status.rawValue)")
            
            switch  status {
            case .notDetermined, .restricted, .denied:
                
                return false
                
            case .authorizedWhenInUse, .authorizedAlways:
                
                return true
            default:
                break
            }
        }
        
        return false
    }
    
    func requestLocationAuthorizaiton() {
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let block = getAuthHandle {
            if hasLocationPermission() {
                block(true)
            } else {
                block(false)
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if let block = getAuthHandle {
            if hasLocationPermission() {
                block(true)
            } else {
                block(false)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last {
            
            print("latitude: \(loction.coordinate.latitude)   longitude:\(loction.coordinate.longitude)")
            
            if let block = getLocationHandle {
                block(true, loction.coordinate.latitude, loction.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if let block = getLocationHandle {
            block(false, 0, 0)
        }
        print("get location failed. error:\(error.localizedDescription)")
    }
    
}
