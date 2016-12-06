//
//  CampaignMapViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 30/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MapKit

class CampaignMapViewController: BaseMapViewController {
    
    var mCampaign : ObjectCampaign!
    private var stores : [ObjectStore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        DebugLogger.debugLog("mCampaign.beacons \(mCampaign.beacons)")

        stores = self.mCampaign.getStores()

        self.loadMap()
        self.title = self.mCampaign.merchant!.merchantName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func    loadMap(){
        
        for item in stores {
            DebugLogger.debugLog("item \(item.getLocation())")
            let lat : Double = item.geoLocation.latitude!.doubleValue
            let lng : Double  = item.geoLocation.longitude!.doubleValue
            let mkPointAnnotation = MKPointAnnotation()
            
            mkPointAnnotation.coordinate = CLLocationCoordinate2DMake(lat,lng)
            mkPointAnnotation.title = item.storeName ?? "Store"
            mkPointAnnotation.subtitle = item.cityName!
            
            mapView.addAnnotation(mkPointAnnotation)
        }
        self.setUserMapInitialLocation()
    }

    
    func setUserMapInitialLocation(){
        
        var nearestDistance : Double  = -10000
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
            case .NotDetermined, .Restricted, .Denied:
                DebugLogger.debugLog("No access")
                ProximateSDK.getMessageDelegate()?.showMessage("Please enable location services")
                
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                DebugLogger.debugLog("Access")
//
                if stores.count > 0{
                    let lat : Double = stores[0].geoLocation.latitude!.doubleValue
                    let lng : Double  = stores[0].geoLocation.longitude!.doubleValue
                    let storeLoc = CLLocation(latitude: lat, longitude: lng)
                    if nearestDistance == -10000.0 {
                        if let   distance      = self.locationManager.location?.distanceFromLocation(storeLoc) {
                            nearestDistance = distance
                            centerMapOnLocation(storeLoc)
                        }
                    } else {
                        if nearestDistance >  locationManager.location!.distanceFromLocation(storeLoc){
                            nearestDistance = locationManager.location!.distanceFromLocation(storeLoc)
                            centerMapOnLocation(storeLoc)
                        }
                    }
                } else {
                    centerMapOnLocation( locationManager.location!)
                }
//
            default:
                DebugLogger.debugLog("...")
            }
            
        } else {
            ProximateSDK.getMessageDelegate()?.showMessage("Please enable location services")
        }
    }

}
