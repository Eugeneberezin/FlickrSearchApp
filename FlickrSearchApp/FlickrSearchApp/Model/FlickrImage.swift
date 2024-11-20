//
//  FlickrImage.swift
//  FlickrSearchApp
//
//  Created by Eugene Berezin on 11/19/24.
//

import Foundation

struct FlickrImage: Identifiable {
    let id = UUID()
    let title: String
    let imageUrl: URL
    let author: String
    let description: String
    let published: Date
}

