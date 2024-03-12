//
//  ImagesView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct ImagesView: View {
    @StateObject
    private var viewModel = ImagesViewModel()
 
    @State
    private var screenHeight: CGFloat = .zero

    var body: some View {
        contentOrError
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.screenHeight = proxy.size.height
                        }
                }
            }
            .task {
                await viewModel.fetchLatestPictures()
            }
            .ignoresSafeArea()
    }
}

// MARK: - ViewBuilders
private extension ImagesView {
    
    @ViewBuilder
    var contentOrError: some View {
        if viewModel.loading, viewModel.images.isEmpty {
            // TODO: Some redaction effect
            Text("Loading")
        } else if let error = viewModel.error, viewModel.images.isEmpty {
            // TODO: A nice error view
            Text("Error: \(error.localizedDescription)")
        } else {
            scrollView
                .overlay {
                    ImageViewControlsOverlay(screenHeight: screenHeight)
                }
        }
    }
 
    var scrollView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .zero) {
                ForEach(viewModel.images) { image in
                    ImageFullscreenCell(screenHeight: screenHeight, image: image)
                        .task {
                            await viewModel.fetchLatestPictures()
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .frame(maxHeight: .infinity)
    }
}


#Preview {
    ImagesView()
        .environmentObject(ChatAlbumsViewModel())
}
