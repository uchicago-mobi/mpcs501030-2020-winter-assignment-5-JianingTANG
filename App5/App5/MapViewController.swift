//
//  MapViewController.swift
//  App5
//
//  Created by Jianing Tang on 2/11/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {


    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Description: UILabel!


    @IBAction func starAction(_ sender: Any) {
            if DataManager.sharedInstance.defaultMemory.object(forKey: Name.text!)==nil {
                (sender as AnyObject).setImage(UIImage(systemName:"star.fill"), for: .normal)
                DataManager.sharedInstance.saveFavorites(Name.text!)
            }
            else{
                (sender as AnyObject).setImage(UIImage(systemName:"star"), for: .normal)
                DataManager.sharedInstance.deleteFavorites(Name.text!)
            }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        Name.contentMode = .scaleToFill
        Description.contentMode = .scaleToFill
        Description.numberOfLines  = 0
        DataManager.sharedInstance.loadAnnotationFromPlist(filename: "Data")
        addAnnotations()
        setInitialLocation()
    }
    
    func setInitialLocation(){
        let regions = DataManager.sharedInstance.region
        let center = CLLocationCoordinate2DMake(CLLocationDegrees(truncating: regions[0]),CLLocationDegrees(truncating: regions[1]))
        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(truncating: regions[2]), longitudeDelta: CLLocationDegrees(truncating: regions[3]))
        let initLocation = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(initLocation, animated: true)
        Name.text = "Chicago"
        Description.text = "The most populous city in the U.S. state of Illinois"
        
    }
    
    func addAnnotations(){
        let placeAnnotations = DataManager.sharedInstance.placeAnnotations
        for (_, place) in placeAnnotations{
            mapView.addAnnotation(place)
        }
    }
}

extension MapViewController : MKMapViewDelegate, PlacesFavoritesDelegate{
    func favoritePlace(name: String) {
        // Update the map view based on the favorite
        // place that was passed in
        let favPlace = DataManager.sharedInstance.defaultMemory.object(forKey: name) as! Place
        Name.text = favPlace.title!
        Description.text = favPlace.subtitle!
        mapView.setRegion(DataManager.sharedInstance.getCoordinate(name: name), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Tapped a callout")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place{
            let identifier = "CustonPin"
            // create a new view
            var view: MKPinAnnotationView
            
            // dequeue a view or create a new one
            if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier:
                identifier) as? MKPinAnnotationView{
                dequeueView.annotation = annotation
                view = dequeueView
            }
            else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        return view as? MKAnnotationView
    }
}
