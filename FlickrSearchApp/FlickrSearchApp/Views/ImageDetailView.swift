//
//  ImageDetailView.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: FlickrImage

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: image.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.gray
                }
            }
            Text("Title: \(image.title)")
            Text("Description: \(image.description)")
            Text("Author: \(image.author)")
            Text("Published: \(formatDate(image.published))")
        }
        .padding()
    }

    // Helper function to format the date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

