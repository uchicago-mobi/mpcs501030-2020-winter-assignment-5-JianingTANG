//
//  DataManager.swift
//  App5
//
//  Created by Jianing Tang on 2/12/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class DataManager {
    
    var region = [NSNumber]()
    var placeAnnotations : [String: Place] = [:]
    var favPlaceNames : [String] = []
    var defaultMemory = UserDefaults.standard
    
  
  // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
  
  //This prevents others from using the default '()' initializer
    fileprivate init() {}
    

  // Your code (these are just example functions, implement what you need)
    func loadAnnotationFromPlist(filename: String) {
        var placesAndRegionsDictionary : NSDictionary?
        if let path = Bundle.main.path(forResource: "Data", ofType: "plist") {
            placesAndRegionsDictionary = NSDictionary(contentsOfFile: path)
        }
        
        region = placesAndRegionsDictionary?["region"] as! [NSNumber]
        let places = placesAndRegionsDictionary?["places"] as! [NSDictionary]
    
        for place in places{
            let name = place["name"] as! String
            let description = place["description"] as! String
            let latitude = place["lat"] as! Double
            let longtitude = place["long"] as! Double
            let coordinate = CLLocationCoordinate2DMake(latitude, longtitude)
            let placeAnnotation = Place(title: name, subtitle: description, coordinate: coordinate)
            placeAnnotations[name] = placeAnnotation
        }
        
        
    }
    
    func saveFavorites(_ name: String) -> Void{
        let place: Place = placeAnnotations[name]!
        print("trying to save ", place.title!)
//        if favPlaceNames.firstIndex(of: name) == nil {
//            print("default")
//            defaultMemory.set(place, forKey: name)
//            print("fav list")
            favPlaceNames.append(name)
//        }
    }
    
    func deleteFavorites(_ name: String) -> Void {
        print("trying to delete ", name)
//        defaultMemory.removeObject(forKey: name)
        if let index = favPlaceNames.firstIndex(of: name) {
            favPlaceNames.remove(at: index)
        }
    }
    
    func listFavorites() ->[Place]{
        var userFavoritePlaceList: [Place] = []
        for key in favPlaceNames{
            userFavoritePlaceList.append(defaultMemory.object(forKey: key) as! Place)
        }
        return userFavoritePlaceList
    }
    
    func getCoordinate(name placeName: String) -> MKCoordinateRegion {
        //init(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
        let place = defaultMemory.object(forKey: placeName) as! Place
        let center = place.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0)
        return MKCoordinateRegion(center: center, span: span)
        
    }
  
}

