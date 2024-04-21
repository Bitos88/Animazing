//
//  ContentView.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import SwiftUI

struct AnimesList: View {
    @EnvironmentObject var vm:AnimeListVM
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                List(vm.filteredAnimes) { anime in
                    NavigationLink(value: anime) {
                        AnimesListCell(anime: anime, animeStatus: anime.status)
                    }
                }
                .navigationDestination(for: AnimeModel.self, destination: { anime in
                    DetailView(anime: anime, animeStatus: anime.status, showViewed: anime.isViewed)
                })
                .searchable(text: $vm.search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Your Anime")
                .animation(.spring(), value: vm.search)
                .navigationTitle("Animazing")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Menu {
                                Picker("OrderBy" ,selection: $vm.sortBy) {
                                    ForEach(SortBy.allCases) { sorted in
                                        Text(sorted.rawValue)
                                    }
                                }
                            } label: {
                                Image(systemName: "list.star")
                            }
                            Menu {
                                Picker("SortByType", selection: $vm.animesType) {
                                    ForEach(AnimeType.allCases, id: \.self ) { type in
                                        Text(type.rawValue)
                                    }
                                }
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AnimesList_Previews: PreviewProvider {
    static var previews: some View {
        AnimesList()
            .environmentObject(AnimeListVM.preview)
            .preferredColorScheme(.dark)
    }
}
