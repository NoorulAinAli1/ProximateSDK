//
//  MerchantMapViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 30/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MapKit

class MerchantMapViewController: BaseMapViewController {

    var mMerchant : ObjectMerchant!
    private var stores : [ObjectMerchantStore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.mMerchant!.merchantName

        ApiHandler.sharedInstance.getStoresForMerchant(self.mMerchant.getMerchantId(),   completion:({
            merchantStores in
            if merchantStores.count == 0 {
           
            } else {
                self.stores.appendContentsOf(merchantStores)
                self.loadMap()
            }
        }))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    func    loadMap(){
        
        for item in stores {
            DebugLogger.debugLog("item \(item.getLocation())")
            let lat : Double = item.getLatitude()
            let lng : Double  = item.getLongitude()
            let mkPointAnnotation = MKPointAnnotation()
            
            mkPointAnnotation.coordinate = CLLocationCoordinate2DMake(lat,lng)
            mkPointAnnotation.title = item.storeTitle ?? "Store"
            mkPointAnnotation.subtitle = item.getSnippet()
            
            mapView.addAnnotation(mkPointAnnotation)
            
        }
        
        self.setUserMapInitialLocation()

    }
    
    func setUserMapInitialLocation(){
        
        var nearestDistance : Double  = -10000
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                DebugLogger.debugLog("Access")
                
                if stores.count > 0{
                    let lat : Double = stores[0].getLatitude()
                    let lng : Double  = stores[0].getLongitude()
                    let storeLoc = CLLocation(latitude: lat, longitude: lng)
                    if nearestDistance == -10000.0 {
                        if let distance = self.locationManager.location?.distanceFromLocation(storeLoc) {
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
//            case .NotDetermined, .Restricted, .Denied:
            default:
                DebugLogger.debugLog("No access")
                ProximateSDK.getMessageDelegate()?.showMessage("psdk_message_enable_location_services".localized, forMessageType: .Error)
            }
            
        } else {
            ProximateSDK.getMessageDelegate()?.showMessage("psdk_message_enable_location_services".localized, forMessageType: .Error)
        }
    }

}
