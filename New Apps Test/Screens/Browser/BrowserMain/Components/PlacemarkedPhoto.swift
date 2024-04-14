//
//  PlacemarkedPhoto.swift
//  New Apps Test
//
//  Created by The Sebag Company on 13/04/2024.
//

import CoreLocation
import SwiftUI

struct PlacemarkedPhoto: View {
    @State
    private var pointOfInterest: String = ""
    
    let photo: PhotoItem
    
    var body: some View {
        VStack(spacing: 8) {
            albumPhoto(for: photo)
            Text(pointOfInterest)
                .font(.subheadline)
                .foregroundStyle(.white)
                .lineLimit(1)
                .frame(width: 140, alignment: .leading)
        }
        .task {
            await computePoi()
        }
    }
}

// MARK: ViewBuilders
private extension PlacemarkedPhoto {
    func albumPhoto(for photo: PhotoItem) -> some View {
        AsyncImage(url: photo.image) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
            
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Material.thin)
        }
        .frame(width: 140, height: 100)
        .mask(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Actions
private extension PlacemarkedPhoto {
    func computePoi() async {
        self.pointOfInterest = await PlacemarkHelper.computePointOfInterest(from: photo.location) ?? ""
        if self.pointOfInterest.isEmpty {
            self.pointOfInterest = await PlacemarkHelper.computeCity(from: photo.location) ?? ""
        }
    }
}

#Preview {
    PlacemarkedPhoto(
        photo: PhotoItem(
            id: 11,
            title: "Wow",
            image: URL(string: "https://plus.unsplash.com/premium_photo-1689523819186-cfe67633ad49?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            location: CLLocation(
                latitude: 48.8738,
                longitude: 2.2950
            )
        )
    )
}
