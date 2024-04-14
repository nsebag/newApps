//
//  FullScreenPhotoViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import Foundation

class FullScreenPhotoViewModel: ObservableObject {
    @Published
    var photoItem: PhotoItem
    
    @Published
    private(set) var city: String?
    @Published
    private(set) var poi: String?
    
    
    init(photoItem: PhotoItem) {
        self.photoItem = photoItem
    }
    
    func computePlacemarks() async {
        let city = await PlacemarkHelper.computeCity(from: photoItem.location)
        let poi = await PlacemarkHelper.computePointOfInterest(from: photoItem.location)
        
        await MainActor.run {
            self.city = city
            self.poi = poi
        }
    }
}
