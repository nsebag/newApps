//
//  ImageFullscreenCell.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct ImageFullscreenCell: View {
    let screenHeight: CGFloat
    let image: ImageViewData
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: screenHeight)
        
            .overlay {
                imageCell(from: image.url)
                    .scaledToFit()
            }
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension ImageFullscreenCell {
    func imageCell(from url: URL) -> some View {
        AsyncImage(url: url) { image in
            loadedImage(image: image)                
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(.black.opacity(0.5))
                .frame(minHeight: 100)
        }

    }
    
    func loadedImage(image: Image) -> some View {
        ZStack {
            image
                .scaledToFill()
                .frame(height: screenHeight)
                .blur(radius: 25.0)
                .ignoresSafeArea()
                .clipped()
            
            image
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    // NOTE(*): UIScreen seems tolerated here for preview
    ImageFullscreenCell(
        screenHeight: UIScreen.main.bounds.height,
        image: ImageViewData(
            id: "AAAA",
            url: URL(string: "https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
        )
    )
}
