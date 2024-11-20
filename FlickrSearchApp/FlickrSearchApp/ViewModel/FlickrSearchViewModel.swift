//
//  FlickrSearchViewModel.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import Foundation

@MainActor
class FlickrSearchViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var isLoading: Bool = false

    private let service: FlickrServiceProtocol

    // Dependency injection
    init(service: FlickrServiceProtocol = FlickrService()) {
        self.service = service
    }

    func searchImages(for query: String) async {
        guard !query.isEmpty else {
            self.images = [] // Clear images for an empty query
            return
        }

        isLoading = true
        do {
            let results = try await service.fetchImages(searchText: query)
            self.images = results
        } catch {
            print("Error fetching images: \(error)")
            self.images = []
        }
        isLoading = false
    }
}
