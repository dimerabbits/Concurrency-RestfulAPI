//  Adam Herring
//  ContentView.swift
//  ConcurrencyRESTapi
//
//  Created by Adam on 10/23/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var photos = Photos()
    
    var body: some View {
        NavigationView {
            List {
                photosSection
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Photos")
            .task {
                await photos.fetchUpdates()
            }
            .refreshable {
                await photos.fetchUpdates()
            }
        }
    }
    
    var photosSection: some View {
        Section {
            ForEach(photos.items) { item in
                NavigationLink(
                    destination: AsyncImage(url: URL(string: item.url)),
                    isActive: $photos.isShowingDetailView
                ) {
                    HStack(spacing: 15) {
                        AsyncImage(url: URL(string: item.thumbnailUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(7)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                            Text("Album: \(item.albumId) Photo: \(item.id)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
