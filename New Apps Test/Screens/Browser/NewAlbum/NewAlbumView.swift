//
//  NewAlbumView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import SwiftUI

struct NewAlbumView: View {
    @StateObject
    private var viewModel: NewAlbumViewModel = .init()
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    .init(.flexible()),
                    .init(.flexible()),
                    .init(.flexible())
                    
                ],
                spacing: 8
            ) {
                ForEach(viewModel.photos.indices, id: \.self) { idx in
                    Button(
                        action: {
                            viewModel.photos[idx].selected.toggle()
                        },
                        label: {
                            imageButton(for: idx)
                        }
                    )
                    .overlay {
                        if viewModel.photos[idx].selected {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.blue, lineWidth: 2)
                        }
                    }
                }
            }
            .safeAreaPadding(8)
        }
        .scrollIndicators(.hidden)
        .task {
            await viewModel.fetchImages()
        }
        .navigationTitle("New Album")
        .toolbarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("Next")
                            .font(.callout.bold())
                    }
                )
                .disabled(!viewModel.photos.contains(where: { $0.selected }))
            }
        }
    }
}

private extension NewAlbumView {
    func imageButton(for idx: Int) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.clear)
            .background {
                imageCell(for: viewModel.photos[idx].url)
            }
            .frame(minHeight: 200)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func imageCell(for url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
                .id("image_loaded_\(url?.absoluteString ?? "")")
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Material.ultraThinMaterial)
        }
        .id("image_\(url?.absoluteString ?? "")")
        .clipped()
    }
}

#Preview {
    NavigationStack {
        NewAlbumView()
    }
}
