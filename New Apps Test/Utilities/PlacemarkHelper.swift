//
//  PlacemarkHelper.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import CoreLocation
import Foundation

struct PlacemarkHelper {
    static func computePointOfInterest(from location: CLLocation) async -> String? {
        let geoCoder = CLGeocoder()
        guard
            let placemarks = try? await geoCoder.reverseGeocodeLocation(location),
            let placemark = placemarks.first
        else {
            return nil
        }
        
        return placemark.areasOfInterest?.first
    }
    
    static func computeCity(from location: CLLocation) async -> String? {
        let geoCoder = CLGeocoder()
        guard
            let placemarks = try? await geoCoder.reverseGeocodeLocation(location),
            let placemark = placemarks.first
        else {
            return nil
        }
        
        return placemark.locality
    }
}
