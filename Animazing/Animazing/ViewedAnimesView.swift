//
//  ViewedAnimesView.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 6/5/23.
//

import SwiftUI

struct ViewedAnimesView: View {
    @EnvironmentObject var vm:AnimeListVM

    var body: some View {
        NavigationStack {
            if vm.showViewedAnimes().isEmpty {
                VStack(spacing: 5) {
                    Spacer()
                    Text("No viewed anime selected")
                        .font(.title)
                    Text("Please select a viewed anime to add to the list")
                }
            }
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(vm.showViewedAnimes()) { anime in
                            NavigationLink(value: anime) {
                                VStack {
                                    AsyncImage(url: URL(string: anime.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(width: 150, height: 250)
                                    } placeholder: {
                                        Image(systemName: "popcorn")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 250)
                                    }
                                }
                            }
                        }
                }
                .padding(.horizontal)
            }
            .navigationDestination(for: AnimeModel.self
                                   , destination: { anime in
                DetailView(anime: anime, animeStatus: anime.status, showViewed: anime.isViewed)
            })
            .navigationTitle("ViewedAnimes")
        }
    }
}

struct ViewedAnimesView_Previews: PreviewProvider {
    static var previews: some View {
        ViewedAnimesView()
            .environmentObject(AnimeListVM.preview)
            .preferredColorScheme(.dark)

    }
}
