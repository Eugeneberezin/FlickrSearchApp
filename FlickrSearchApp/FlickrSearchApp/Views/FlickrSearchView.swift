//
//  FlickrSearchView.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import SwiftUI

struct FlickrSearchView: View {
    @StateObject private var viewModel = FlickrSearchViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Ensure no spacing between components
                // Search bar stays fixed at the top
                TextField("Search images...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: searchText) { newValue in
                        Task {
                            await viewModel.searchImages(for: newValue)
                        }
                        
                    }
                    .background(Color(.systemBackground)) // Matches app background

                // Scrollable content below
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ImageGridView(images: viewModel.images)
                        .padding(.top, 8) // Add padding between search bar and grid
                }
            }
            .navigationTitle("Flickr Search")
            .ignoresSafeArea(edges: .bottom) // Prevent shifting when keyboard appears
        }
    }
}


