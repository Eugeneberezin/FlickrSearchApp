//
//  FlickrService.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import Foundation

protocol FlickrServiceProtocol {
    func fetchImages(searchText: String) async throws -> [FlickrImage]
}

class FlickrService: FlickrServiceProtocol {
    func fetchImages(searchText: String) async throws -> [FlickrImage] {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchText)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let json = try decoder.decode(FlickrResponse.self, from: data)
        return json.items.map { item in
            FlickrImage(
                title: item.title,
                imageUrl: item.media.m,
                author: item.author,
                description: item.description,
                published: item.published
            )
        }
    }
}

// Helper JSON Response Structures
private struct FlickrResponse: Decodable {
    let items: [FlickrItem]
}

private struct FlickrItem: Decodable {
    let title: String
    let media: FlickrMedia
    let author: String
    let description: String
    let published: Date
}

private struct FlickrMedia: Decodable {
    let m: URL
}
