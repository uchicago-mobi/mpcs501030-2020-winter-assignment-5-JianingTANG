//
//  PlaceMarkerView.swift
//  App5
//
//  Created by Jianing Tang on 2/11/20.
//  Copyright © 2020 Jianing Tang. All rights reserved.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    /*
    An annotation view that displays a balloon-shaped marker at the designated location.
    */
    
    override var annotation: MKAnnotation?{
        willSet{
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemBlue
            glyphImage = UIImage(systemName: "pin.fill")
        }
    }

}
