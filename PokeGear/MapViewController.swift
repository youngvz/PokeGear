//
//  MapViewController.swift
//  PokeGear
//
//  Created by Viraj Shah on 7/17/16.
//  Copyright © 2016 Vetek Systems. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    let navBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let mapContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.redColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var currentLocation = CLLocation()
    
    
    let layout = UICollectionViewFlowLayout()
    
    
    
    lazy var pokedexIcon: UIImageView = {
        let pokedex = UIImageView()
        pokedex.translatesAutoresizingMaskIntoConstraints = false
        pokedex.image = UIImage(named: "PokedexIcon")
        pokedex.isUserInteractionEnabled = true
        pokedex.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePokedex)))
        return pokedex
        
    }()
    
    
    func handlePokedex(){
        let pokedexController = PokedexController(collectionViewLayout: layout)
        let pokedexNavController = UINavigationController(rootViewController: pokedexController)
        pokedexNavController.navigationBar.barTintColor = UIColor.red
        pokedexNavController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        pokedexNavController.navigationBar.tintColor = UIColor.white

        
        pokedexIcon.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 4.0,
                                   options: UIViewAnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.pokedexIcon.transform = CGAffineTransform.identity
            }, completion: {
                (value: Bool) in
                
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = kCATransitionMoveIn
                transition.subtype = kCATransitionFromLeft
                self.view.window!.layer.add(transition, forKey: kCATransition)
                self.present(pokedexNavController, animated: false, completion: nil)
        })
        
        
        //pokedexNavController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        
        
        
            }
    
//    let geoCoder = CLGeocoder()
//    let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
//    
//    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//    
//    // Place details
//    var placeMark: CLPlacemark!
//    placeMark = placemarks?[0]
//    
//    // Location name
//    if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
//    print(locationName)
//    }
//    
//    // City
//    if let city = placeMark.addressDictionary!["City"] as? NSString {
//    print(city)
//    }

    
    
    lazy var gpsIcon: UIImageView = {
        let gps = UIImageView()
        gps.translatesAutoresizingMaskIntoConstraints = false
        gps.image = UIImage(named: "gps")
        gps.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomIn)))
        gps.isUserInteractionEnabled = true
        gps.tintColor = UIColor.blue
        return gps
        
    }()
    
    
    
    lazy var mapView: MKMapView = {
    
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = .standard
        map.showsPointsOfInterest = false
        map.showsCompass = true
        map.showsBuildings = true
        map.showsUserLocation = true
        map.frame = self.view.frame
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.delegate = self
        map.tintColor = UIColor.red
        return map
    }()
    
    lazy var locationManager: CLLocationManager = {
       let location = CLLocationManager()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestAlwaysAuthorization()
        location.startUpdatingLocation()
        return location
        
        
    }()

    
    override func viewDidLoad() {
        
        //Map View Constraints
        setupMapView()
        
        //self.navigationController?.navigationBar.hidden = true
        super.viewDidLoad()
        
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation.isEqual(mapView.userLocation){
//            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
//            annotationView.image = UIImage(named: "Trainer")
//            return annotationView
//        }else{
//            return nil
//        }
//    }
    
    func setupMapView(){
        
            view.addSubview(mapContainerView)
            view.addSubview(mapView)
            view.addSubview(pokedexIcon)
            view.addSubview(gpsIcon)
            view.addSubview(navBarView)
        
            mapContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            mapContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            mapContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            mapContainerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

            navBarView.leftAnchor.constraint(equalTo: mapContainerView.leftAnchor).isActive = true
            navBarView.topAnchor.constraint(equalTo: mapContainerView.topAnchor).isActive = true
            navBarView.widthAnchor.constraint(equalTo: mapContainerView.widthAnchor).isActive = true
            navBarView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
            mapView.centerXAnchor.constraint(equalTo: mapContainerView.centerXAnchor).isActive = true
            mapView.centerYAnchor.constraint(equalTo: mapContainerView.centerYAnchor).isActive = true
            mapView.widthAnchor.constraint(equalTo: mapContainerView.widthAnchor).isActive = true
            mapView.heightAnchor.constraint(equalTo: mapContainerView.heightAnchor).isActive = true
        
        
            pokedexIcon.leftAnchor.constraint(equalTo: mapView.leftAnchor,constant: 6).isActive = true
            pokedexIcon.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 24).isActive = true
            pokedexIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
            pokedexIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
            gpsIcon.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -8).isActive = true
            gpsIcon.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60).isActive = true
            gpsIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
            gpsIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
            zoomIn()
        
    }
    
    func zoomIn(){
        
        print(123)
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            
            if let coordinate = locationManager.location?.coordinate {
            
                
                print(coordinate)
            let region = MKCoordinateRegionMakeWithDistance(
                coordinate, 500, 500)
            
            mapView.setRegion(region, animated: true)
            }
        }
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last as CLLocation!
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        self.mapView.setRegion(region, animated: true)
//    }


}

