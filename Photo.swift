//  Adam Herring
//  Photo.swift
//  ConcurrencyRESTapi
//
//  Created by Adam on 10/23/21.
//

import SwiftUI

struct Photo: Identifiable, Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

class Photos: ObservableObject {
    @Published var items: [Photo] = []
    @Published var isShowingDetailView = false
    
    @MainActor
    func fetchUpdates() async {
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
            let (data, _) = try await URLSession.shared.data(from: url)
            items = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            print("Error")
        }
    }
}
