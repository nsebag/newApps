//
//  NewAlbumViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import Foundation

struct NewAlbumPhoto: Identifiable {
    let id: String
    let url: URL?
    var selected: Bool
}

class NewAlbumViewModel: ObservableObject {
    private let service = UnsplashService()
    
    @Published
    var photos: [NewAlbumPhoto] = []
    
    func fetchImages() async {
        let result = await service.fetchLatestImages(page: 1)
        switch result {
        case .success(let success):
            let mappedResult: [NewAlbumPhoto] = success.compactMap { image in
                guard let id = image.id else { return nil }
                return NewAlbumPhoto(
                    id: id,
                    url: image.urls?.regular,
                    selected: false
                )
            }
            await updateImages(newPhotos: mappedResult)
        case .failure(let failure):
            print("here \(failure.localizedDescription)")
            return
        }
    }
}

// MARK: - View updates
private extension NewAlbumViewModel {
    @MainActor
    func updateImages(newPhotos: [NewAlbumPhoto]) async {
        self.self.photos = newPhotos
    }
}
