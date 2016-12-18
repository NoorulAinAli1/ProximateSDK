//
//  MapCampaignActionViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MapKit

class MapCampaignActionViewController: BaseMapViewController {
    var mCampaignAction : ObjectCampaignAction!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = mCampaignAction.actionTitle
        
        self.loadMap()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func   loadMap(){
        
        let coordinates = mCampaignAction.getMapCoordinates()
        
        let mkPointAnnotation = MKPointAnnotation()
        
        mkPointAnnotation.coordinate = CLLocationCoordinate2DMake(coordinates.lat, coordinates.lng)
        mkPointAnnotation.title = mCampaignAction.actionTitle
//        mkPointAnnotation.subtitle = mCampaignAction
        mapView.addAnnotation(mkPointAnnotation)
        self.setUserMapInitialLocation()
    }
    
    func setUserMapInitialLocation(){
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                DebugLogger.debugLog("Access")
                
                centerMapOnLocation( locationManager.location!)
                
//            case .NotDetermined, .Restricted, .Denied:
            default:
                DebugLogger.debugLog("No access")
                ProximateSDK.getMessageDelegate()?.showMessage("psdk_message_enable_location_services".localized, forMessageType: .Error)
            }
            
        } else {
            ProximateSDK.getMessageDelegate()?.showMessage("psdk_message_enable_location_services".localized, forMessageType: .Error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
