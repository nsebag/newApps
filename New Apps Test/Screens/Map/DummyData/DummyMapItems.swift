//
//  DummyMapItems.swift
//  New Apps Test
//
//  Created by The Sebag Company on 11/04/2024.
//

import Foundation
import MapKit

enum DummyData {
    static let userMapItems: [PhotoItem] = [
        PhotoItem(
            id: 3,
            title: "",
            image: URL(string: "https://plus.unsplash.com/premium_photo-1682116752956-c880046f5361?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 40.7829,
                longitude: 73.9654
            )
        ),
        PhotoItem(
            id: 4,
            title: "",
            image: URL(string: "https://images.unsplash.com/photo-1522092372459-dff01028d904?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 40.7061,
                longitude: 73.9969
            )
        ),
        PhotoItem(
            id: 5,
            title: "",
            image: URL(string: "https://images.unsplash.com/photo-1554797589-7241bb691973?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 35.6895,
                longitude: 139.6917
            )
        ),
        PhotoItem(
            id: 6,
            title: "",
            image: URL(string: "https://images.unsplash.com/photo-1490806843957-31f4c9a91c65?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 35.3606,
                longitude: 138.7274
            )
        ),
        PhotoItem(
            id: 7,
            title: "",
            image: URL(string: "https://images.unsplash.com/photo-1585944285854-d06c019aaca3?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 48.8867,
                longitude: 2.3431
            )
        ),
        PhotoItem(
            id: 8,
            title: "",
            image: URL(string: "https://images.unsplash.com/photo-1454692173233-f4f34c12adad?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 40.7358,
                longitude: 74.0036
            )
        )
    ]
}
