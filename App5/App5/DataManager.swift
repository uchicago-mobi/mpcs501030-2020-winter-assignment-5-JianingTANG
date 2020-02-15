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
        
        if defaultMemory.object(forKey: "favPlace") == nil{
            let favPlaceList : [String] = []
            defaultMemory.set(favPlaceList, forKey: "favPlace")
        }        
    }
    
    func saveFavorites(_ name: String) -> Void{
        var favPlaceList: [String] = defaultMemory.object(forKey: "favPlace") as! [String]
        if favPlaceList.firstIndex(of: name) == nil {
            favPlaceList.append(name)
            defaultMemory.set(favPlaceList, forKey: "favPlace")
        }
    }
    
    func deleteFavorites(_ name: String) -> Void {
        var favPlaceList: [String] = defaultMemory.object(forKey: "favPlace") as! [String]
        if let index = favPlaceList.firstIndex(of: name) {
            favPlaceList.remove(at: index)
        }
        defaultMemory.set(favPlaceList, forKey: "favPlace")
    }
    
    func listFavorites() ->[Place]{
        var userFavoritePlaceList : [Place] = []
        let favPlaceList: [String] = defaultMemory.object(forKey: "favPlace") as! [String]
        for name in favPlaceList{
            userFavoritePlaceList.append(placeAnnotations[name]!)
        }
        return userFavoritePlaceList
    }
    
    func getCoordinate(name placeName: String) -> MKCoordinateRegion {
        //init(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
        let place = placeAnnotations[placeName]
        let center = place!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        return MKCoordinateRegion(center: center, span: span)
        
    }
  
}

