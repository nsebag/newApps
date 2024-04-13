//
//  MapView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 11/04/2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject
    private var viewModel = MapViewModel()
    @EnvironmentObject
    private var browserViewModel: BrowserViewModel
    
    @State
    private var currentDetent: PresentationDetent = .fraction(1/2)
    
    @State private var browserContentSize: CGSize = .zero
    
    var body: some View {
        VStack {
            MapReader { mapProxy in
                map
                    .task {
                        viewModel.setItems(from: browserViewModel.albums)
                        viewModel.updateClusters(from: mapProxy.visibleRegion)
                    }
                    .onChange(of: browserViewModel.selectedImageId) {
                        guard let photo = viewModel.items.first(where: { $0.id == browserViewModel.selectedImageId }) else { return }
                        viewModel.focusCamera(on: photo)
                    }
                    .onChange(of: browserViewModel.selectedAlbumId) {
                        guard
                            browserViewModel.selectedAlbumId != nil,
                            let selectedAlbum = browserViewModel.albums.first(where: {
                                $0.id == browserViewModel.selectedAlbumId
                            })
                        else {
                            viewModel.resetCamera()
                            return
                        }
                        viewModel.focusCamera(on: selectedAlbum)
                    }
                    .onMapCameraChange(frequency: .onEnd) { context in
                        print("here camera change")
                        viewModel.updateClusters(from: context.region)
                    }
                    .coordinateSpace(.named("map"))
            }
            Spacer()
        }
        .overlay {
            contentOverlay
        }
        .sheet(isPresented: .constant(true)) {
            BrowserView(currentDetent: $currentDetent)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onChange(of: proxy.size, initial: true) { _, _ in
                                browserContentSize = proxy.size
                            }
                    }
                }
                .presentationBackgroundInteraction(.enabled)
                .presentationBackground(.ultraThinMaterial)
                .presentationDetents([
                    .medium,
                    .large
                ],
                 selection: $currentDetent
                )
                .interactiveDismissDisabled()
        }
    }
}

// MARK: - Map View Builders
private extension MapView {

    var contentOverlay: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(
                    action: {
                        browserViewModel.selectAlbum(from: nil)
                        viewModel.resetCamera()
                    },
                    label: {
                        Circle()
                            .fill(Material.ultraThin)
                            .overlay {
                                Image(systemName: "globe.europe.africa.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 28, height: 28)
                    }
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
}

// MARK: - Map View Builders
private extension MapView {
    var map: some View {
        Map(
            position: $viewModel.camera
        ) {
            ForEach(viewModel.clusters) { cluster in
                if let item = cluster.items.first {
                    annotation(for: item)
                }
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .mapControlVisibility(.hidden)
        .frame(height: UIScreen.main.bounds.height - (currentDetent == .large ? 0 : browserContentSize.height))

    }
    
    func makeImage(from url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 42)
        } placeholder: {
            Color.red
        }
        .mask(RoundedRectangle(cornerRadius: 8))
    }
    
    func annotation(for item: PhotoItem) -> some MapContent {
        Annotation("", coordinate: item.location.coordinate, anchor: .center) {
            Button(
                action: {
                    browserViewModel.selectAlbum(from: item)
                },
                label: {
                    loadImage(from: item.image)
                        .id("annotation_\(item.id)")
                        .frame(width: 80, height: 60)

                }
            )
            .mask(RoundedRectangle(cornerRadius: 8))
            .overlay {
                if browserViewModel.selectedImageId == item.id {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                }
            }
        }
        .tag(item.id)
    }
    
    func loadImage(from url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .id(url)
    }
}


#Preview {
    MapView()
        .environmentObject(BrowserViewModel())
}
