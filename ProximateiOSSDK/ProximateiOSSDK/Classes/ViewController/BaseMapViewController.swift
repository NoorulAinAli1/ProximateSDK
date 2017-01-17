//
//  BaseMapViewController.swift
//  ProximateSDK
//
//  Created by NoorulAinAli on 30/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MapKit

class BaseMapViewController: BaseViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    internal var locationStatus : String = ""
    internal var locationManager : CLLocationManager!
    internal let regionRadius: CLLocationDistance = 10000
    internal var actionGeoLocation :String?
    @IBOutlet var mapSegmentedControl : UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.barTintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        
        if let navBarImage = ProximateSDKSettings.psdkViewOptions.navigationBarImage  {
            ProximateSDKSettings.psdkNavBarHasImage = true
            self.self.navigationController?.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: UIBarMetrics.Default)
        } else {
            self.self.navigationController?.navigationBar.barTintColor =  ProximateSDKSettings.psdkViewOptions.primaryColor
            self.self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        }

        initLocationManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @IBAction func mapSegmentChanged(sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = MKMapType.Standard
        case 1:
            self.mapView.mapType = MKMapType.Satellite
        case 2:
            self.mapView.mapType = MKMapType.Hybrid
        default:
            self.mapView.mapType = MKMapType.Standard
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
    
        let reuseIdentifier = "pin"
        
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if v == nil {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            v!.canShowCallout = true
        } else {
            v!.annotation = annotation
        }
        
        v!.image = ProximateSDKSettings.getImageForName("sdk_map_marker")
        return v
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
            	locationStatus = "Status not determine"
            default:
            	locationStatus = "Allowed to location Access"
                shouldIAllow = true
        }
            
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
        regionRadius * 4.0, regionRadius * 4.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
