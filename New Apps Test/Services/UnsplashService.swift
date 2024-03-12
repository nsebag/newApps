//
//  UnsplashService.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import Foundation

enum UnsplashError: Error {
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Something wrong happened"
        }
    }
}

struct UnsplashService {
    // TODO: Use XCEnvironment for minimal security
    private let url: String = "https://api.unsplash.com/"
    private let accessKey: String = "5a3kTAMQ1YvFj7lmKQCP_UOPRTntVhQ24JAGGebWCm4"
    private var httpHeaders: [String: String] {
        [
            "Accept-Version": "v1",
            "Authorization": "Client-ID \(accessKey)"
        ]
    }
    private let pageSize: Int = 2
    
    func fetchLatestImages(page: Int) async -> Result<[UnsplashImage], Error> {
        // TODO: Use Query parameters
        guard let url = URL(string: url + "photos/?page=\(page)&per_page=\(pageSize)") else {
            return .failure(UnsplashError.unknown)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = httpHeaders
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let pictures = try JSONDecoder().decode([UnsplashImage].self, from: data)
            return .success(pictures)
        } catch let error {
            return .failure(error)
        }
    }
}

struct UnsplashImage: Codable {
    struct Urls: Codable {
        let regular: URL?
    }
    
    let id: String?
    let urls: Urls?
}
