//
//  FlickrSearchAppTests.swift
//  FlickrSearchAppTests
//
//  Created by Eugene Berezin on 11/19/24.
//

import XCTest
@testable import FlickrSearchApp

@MainActor
final class FlickrSearchViewModelTests: XCTestCase {
    func testSearchImages() async {
            // Given: A mock service and view model
            let mockService = MockFlickrService()
            let viewModel = FlickrSearchViewModel(service: mockService)

            // When: Performing a search
            await viewModel.searchImages(for: "test")

            // Then: Wait for async operation and verify the results
            XCTAssertFalse(viewModel.images.isEmpty, "Images should not be empty")
            XCTAssertEqual(viewModel.images.count, 1, "There should be exactly one image")
            XCTAssertEqual(viewModel.images.first?.title, "Test Image", "The title should match the mock data")
        }
    func testEmptySearchDoesNotTriggerFetch() async {
        // Given: A mock service and view model
        let mockService = MockFlickrService()
        let viewModel = FlickrSearchViewModel(service: mockService)

        // When: Performing a search with an empty string
        await viewModel.searchImages(for: "")

        // Then: Verify no images are fetched
        XCTAssertTrue(viewModel.images.isEmpty, "Images should remain empty for an empty query")
    }
}

// Mock Service
class MockFlickrService: FlickrServiceProtocol {
    func fetchImages(searchText: String) async throws -> [FlickrImage] {
        guard !searchText.isEmpty else { return [] }

        return [
            FlickrImage(
                title: "Test Image",
                imageUrl: URL(string: "https://example.com/image.jpg")!,
                author: "Test Author",
                description: "Test Description",
                published: Date()
            )
        ]
    }
}
