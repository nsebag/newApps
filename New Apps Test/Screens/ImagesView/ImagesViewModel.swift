//
//  ImagesViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import Foundation

struct ImageViewData: Identifiable, Equatable {
    let id: String
    let url: URL
}

class ImagesViewModel: ObservableObject {
    private let unsplashService = UnsplashService()
    private var currentPage = 0
    
    @Published
    private(set) var images: [ImageViewData] = []
    @Published
    private(set) var error: Error?
    @Published
    private(set) var loading: Bool = false
    
    func fetchLatestPictures() async {
        await setLoading(true)
        currentPage += 1
        let result = await unsplashService.fetchLatestImages(page: currentPage)
        
        switch result {
        case .success(let images):
            await addImages(convert(images))
        case .failure(let error):
            await setError(error)
        }
        await setLoading(false)
    }
}

// MARK: - View updates
private extension ImagesViewModel {
    @MainActor
    func addImages(_ newImages: [ImageViewData]) {
        self.images.append(contentsOf: newImages)
    }
    
    @MainActor
    func setError(_ error: Error) {
        self.error = error
    }
    
    @MainActor
    func setLoading(_ isLoading: Bool) {
        self.loading = isLoading
    }
}

// MARK: - ViewData Conversion
private extension ImagesViewModel {
    func convert(_ images: [UnsplashImage]) -> [ImageViewData] {
        images.compactMap {
            guard
                let id = $0.id,
                let url = $0.urls?.regular
            else { return nil }

            return ImageViewData(
                id: id,
                url: url
            )
        }
    }
}
