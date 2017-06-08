//
//  ViewController.swift
//  Beacon's Major-Minor
//
//  Created by kev on 8.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var majorV: UILabel!
    @IBOutlet var minorV: UILabel!
    @IBOutlet  var uuidV: UILabel!
    
    var locationManager: CLLocationManager!
    
    let uuid = UUID(uuidString: "B0702880-A295-A8AB-F734-031A98A512DE")!
    // You can change uuid for your product
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        if beacons.count > 0 {
            let beacon = beacons[0]
            
            majorV.text = String(describing: beacon.major)
            minorV.text = String(describing: beacon.minor)
            uuidV.text = String(describing: uuid)
           
        }
    }
}

//example output
//[CLBeacon (uuid:<__NSConcreteUUID 0x17e8a2d0> B0702880-A295-A8AB-F734-031A98A512DE, major:5, minor:1000, proximity:1 +/- 0.36m, rssi:-50)]










