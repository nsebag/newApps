//
//  MapProxy+Extensions.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/04/2024.
//

import CoreLocation
import MapKit
import SwiftUI

extension MapProxy {
    var visibleRegion: MKCoordinateRegion {
        let topLeft = CGPoint(x: 0, y: 0)
        let bottomRight = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
        
        guard let topLeftCoord = self.convert(topLeft, from: .local),
              let bottomRightCoord = self.convert(bottomRight, from: .local) else {
            return MKCoordinateRegion()
        }

        let centerLatitude = (topLeftCoord.latitude + bottomRightCoord.latitude) / 2
        let centerLongitude = (topLeftCoord.longitude + bottomRightCoord.longitude) / 2
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        
        let latitudeDelta = abs(topLeftCoord.latitude - bottomRightCoord.latitude)
        let longitudeDelta = abs(topLeftCoord.longitude - bottomRightCoord.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        return MKCoordinateRegion(center: center, span: span)
    }
}
