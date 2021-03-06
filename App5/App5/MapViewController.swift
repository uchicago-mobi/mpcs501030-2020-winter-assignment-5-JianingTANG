//
//  MapViewController.swift
//  App5
//
//  Created by Jianing Tang on 2/11/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    @IBAction func starAction(_ sender: Any) {
        let favPlaceList = DataManager.sharedInstance.defaultMemory
            .object(forKey: "favPlace") as! [String]
        if favPlaceList.firstIndex(of: Name.text!)==nil {
            print("not in fav, add it to fav", Name.text!)
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
            DataManager.sharedInstance.saveFavorites(Name.text!)
        }
        else{
            print("not in fav, add it to fav", Name.text!)
            starButton.setImage(UIImage(systemName:"star"), for: .normal)
            DataManager.sharedInstance.deleteFavorites(Name.text!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        Name.contentMode = .scaleToFill
        Description.contentMode = .scaleToFill
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
        let favPlaceList = DataManager.sharedInstance.defaultMemory
            .object(forKey: "favPlace") as! [String]
        if favPlaceList.firstIndex(of: "Chicago") != nil {
            starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        }
        
    }
    
    func addAnnotations(){
        let placeAnnotations = DataManager.sharedInstance.placeAnnotations
        for (_, place) in placeAnnotations{
            mapView.addAnnotation(place)
        }
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        Name.text = (view.annotation?.title)!
        Description.text = (view.annotation?.subtitle)!
        mapView.setRegion(DataManager.sharedInstance.getCoordinate(name: Name.text!), animated: true)
    }
}

extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        let favPlace = DataManager.sharedInstance.placeAnnotations[name]!
        Name.text = favPlace.title!
        Description.text = favPlace.subtitle!
        starButton.setImage(UIImage(systemName:"star.fill"), for: .normal)
        mapView.setRegion(DataManager.sharedInstance.getCoordinate(name: name), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let receiver = segue.destination as? FavoritesViewController{
            receiver.delegate = self
        }
    }
}
