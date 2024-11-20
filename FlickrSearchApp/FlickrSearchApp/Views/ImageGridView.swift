//
//  ImageGridView.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import SwiftUI

struct ImageGridView: View {
    let images: [FlickrImage]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImage(url: image.imageUrl) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } else {
                                Color.gray
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
            }
        }
    }
}

