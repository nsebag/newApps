//
//  MapViewData.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/04/2024.
//

import CoreLocation
import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    let username: String
    let profilePic: URL?
    let albums: [Album]
}

struct Album: Identifiable, Equatable {
    let id: Int
    let name: String
    let photos: [PhotoItem]
    let users: [User]
    var messages: [Message]
}

struct Message: Identifiable, Equatable {
    let id: Int
    let body: String
    let sender: User
}

struct PhotoItem: Identifiable, Hashable {
    let id: Int
    let title: String?
    let image: URL?
    let location: CLLocation
}

struct MapCluster: Identifiable, Hashable {
    let id: Int
    var items : [PhotoItem]
    let center : CLLocationCoordinate2D
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(center.latitude)
        hasher.combine(center.longitude)
    }
    
    static func == (lhs: MapCluster, rhs: MapCluster) -> Bool {
        lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude
    }
    
    init(id: Int, items: [PhotoItem]) {
        self.id = id
        self.items = items

        let averageLatitude = items.map { $0.location.coordinate.latitude }.reduce(0.0, +) / Double(items.count)
        let averageLongitude = items.map { $0.location.coordinate.longitude }.reduce(0.0, +) / Double(items.count)
        self.center = CLLocationCoordinate2D(latitude: averageLatitude, longitude: averageLongitude)
    }
}
