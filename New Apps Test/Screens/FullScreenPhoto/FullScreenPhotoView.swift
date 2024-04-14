//
//  FullScreenPhotoView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import SwiftUI
import CoreLocation

struct FullScreenPhotoView: View {
    @EnvironmentObject
    private var viewModel: FullScreenPhotoViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    @State
    private var showOverlay: Bool = true
    
    var body: some View {
        ZStack {
            image
                .scaledToFit()

            overlay
                .opacity(showOverlay ? 1 : 0)
                .padding(.horizontal, 16)
        }
        .background {
            image
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.5))
                .blur(radius: 15)

        }
        .withMessageBar(isVisible: true, onSend: { message in
            print("here \(message)")
        })
        .onTapGesture {
            showOverlay.toggle()
        }
        .animation(.spring, value: showOverlay)
        .task {
            await viewModel.computePlacemarks()
        }
    }
}

// MARK: ViewBuilders
private extension FullScreenPhotoView {
    var image: some View {
        AsyncImage(url: viewModel.photoItem.image) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .fill(Material.ultraThinMaterial)
                .scaledToFit()
        }
        .id("fullscreen_\(viewModel.photoItem.image?.absoluteString ?? "")")
    }
    
    var overlay: some View {
        VStack {
            HStack {
                Spacer()
                Button("", systemImage: "xmark") {
                    dismiss()
                }
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)
            }
            
            Spacer()
            imageDescription
        }
    }
    
    var imageDescription: some View {
        VStack(spacing: 4) {
            Text(viewModel.photoItem.title ?? "")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            if let city = viewModel.city {
                Text(city)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let poi = viewModel.poi {
                Text(poi)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    FullScreenPhotoView()
        .environmentObject(
            FullScreenPhotoViewModel(
                photoItem: PhotoItem(
                    id: 5,
                    title: "Tori in the forest",
                    image: URL(string: "https://images.unsplash.com/photo-1601823984263-b87b59798b70?q=80&w=500&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    location: CLLocation(latitude: 35.18945, longitude: 139.02649)
                )
            )
        )
}
