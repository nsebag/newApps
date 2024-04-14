//
//  MapViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 11/04/2024.
//

import CoreLocation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var items: [PhotoItem] = []
    @Published var clusters: [MapCluster] = []
    @Published var camera: MapCameraPosition = .rect(.world)
    
    init() { }
    
    func setItems(from albums: [Album]) {
        items = albums.flatMap { $0.photos }
    }
}

extension MapViewModel {
    func resetCamera() {
        withAnimation(.spring) {
            camera = .rect(.world)
        }
    }
    
    func focusCamera(on photo: PhotoItem) {
        withAnimation(.spring) {
            camera = .region(
                .init(
                    center: photo.location.coordinate,
                    latitudinalMeters: 2000,
                    longitudinalMeters: 2000
                )
            )
        }
    }
    
    func focusFromWorld() {
        guard let firstItem = clusters.first?.items.first else { return }
        withAnimation(.spring) {
            camera = .region(
                .init(
                    center: firstItem.location.coordinate,
                    span: .init(
                        latitudeDelta: 360,
                        longitudeDelta: 360
                    )
                )
            )
        }
    }
    
    func focusCamera(on album: Album) {
        guard
            var minLat = album.photos.first?.location.coordinate.latitude,
            var minLong = album.photos.first?.location.coordinate.longitude
        else { return }
        
        var maxLat = minLat
        var maxLong = minLong
        
        for photo in album.photos {
            minLat = min(minLat, photo.location.coordinate.latitude)
            minLong = min(minLong, photo.location.coordinate.longitude)
            maxLat = max(maxLat, photo.location.coordinate.latitude)
            maxLong = max(maxLong, photo.location.coordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLong + maxLong) / 2
        )

        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLong - minLong) * 1.5
        )

        withAnimation(.spring) {
            camera = .region(.init(center: center, span: span))
        }
    }
}

// MARK: - DBScan
/*
 *  This whole extension was made featuring a nice guy on medium, ChatGPT and some brains.
 *  No over-engineered thing just a hack to make this prototype work with full SwiftUI
 */
extension MapViewModel {
    func updateClusters(from region: MKCoordinateRegion) async {
        let clusters = await self.cluster(from: region)
        await MainActor.run {
            self.clusters = clusters
        }
    }
    
    private func cluster(from region: MKCoordinateRegion) async -> [MapCluster] {
        // Step 1: Initialize clusters
        var newCluster: [MapCluster] = []
        var clusterCount = 0
        let epsilon = calculateEpsilon(from: region)
        var visited = Set<PhotoItem>()
        var noise = Set<PhotoItem>()
        
        // Step 2: Find core points
        for item in items {
            if visited.contains(item) {
                continue
            }
            visited.insert(item)
            
            let neighbors = regionQuery(item: item, epsilon: epsilon)
            if neighbors.count < 1 {
                noise.insert(item)
            } else {
                let cluster = MapCluster(id: clusterCount, items: neighbors)
                clusterCount += 1
                newCluster.append(
                    expandCluster(
                        cluster: cluster,
                        neighbors: neighbors,
                        epsilon: epsilon,
                        visited: &visited,
                        noise: &noise
                    )
                )
            }
        }
        return newCluster
    }
    
    func calculateEpsilon(from region: MKCoordinateRegion) -> Double {
        // Calculate the midpoint latitude for more accurate conversions
        let midLatitude = region.center.latitude

        // Constants for conversions
        let metersPerDegreeLatitude = 111320.0 // Average meters per degree latitude (constant)
        let metersPerDegreeLongitude = 111320.0 * cos(midLatitude * .pi / 180) // Meters per degree longitude varies

        // Convert degree deltas to meters
        let visibleWidthMeters = region.span.longitudeDelta * metersPerDegreeLongitude
        let visibleHeightMeters = region.span.latitudeDelta * metersPerDegreeLatitude

        // Use the smallest dimension to ensure clustering is effective in both width and height
        let smallerDimensionMeters = min(visibleWidthMeters, visibleHeightMeters)

        // Factor determines the portion of the visible area used to define clusters
        // Adjusting the factor value can help tune the clustering granularity
        // A smaller factor value results in larger epsilon and thus larger, fewer clusters
        let factor = 10.0  // Example factor, adjust based on desired clustering behavior
        return smallerDimensionMeters / factor
    }
    
    private func regionQuery(item: PhotoItem, epsilon: Double) -> [PhotoItem] {
        let neighbors = items.filter { neighbor in
            let distance = item.location.distance(from: neighbor.location)
            return distance <= epsilon
        }
        return neighbors
    }
    
    private func expandCluster(
        cluster: MapCluster,
        neighbors: [PhotoItem],
        epsilon: Double,
        visited: inout Set<PhotoItem>,
        noise: inout Set<PhotoItem>
    ) -> MapCluster {
        var expandedCluster = cluster
        var toProcess = neighbors  // Use a queue to manage items to be processed

        while !toProcess.isEmpty {
            let current = toProcess.removeFirst()
            if !visited.contains(current) {
                visited.insert(current)
                let neighborNeighbors = regionQuery(item: current, epsilon: epsilon)
                if neighborNeighbors.count >= 3 {  // Ensuring only valid clusters continue to expand
                    toProcess.append(contentsOf: neighborNeighbors)
                    expandedCluster.items.append(
                        contentsOf: neighborNeighbors.filter {
                            !expandedCluster.items.contains($0)
                        }
                    )
                } else {
                    noise.insert(current)
                }
            }
        }
        
        return expandedCluster
    }
}

// MARK: - Dummy data
extension MapViewModel {
    func makeItems() {
        self.items = DummyData.userMapItems
    }
}
