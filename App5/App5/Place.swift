//
//  Place.swift
//  App5
//
//  Created by Jianing Tang on 2/11/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
