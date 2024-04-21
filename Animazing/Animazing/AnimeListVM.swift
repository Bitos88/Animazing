//
//  AnimeListVM.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import SwiftUI

final class AnimeListVM:ObservableObject {
    
    let persistance:Persistence
    
    @Published var animes:[AnimeModel]
    @Published var search = ""
    @Published var error:String = ""
    
    @Published var sortBy: SortBy = .all
    @Published var animeStatus: AnimeStatus = .unknown
    @Published var animesType: AnimeType = .unknown
    
    
    var filteredAnimes:[AnimeModel] {
        animes.filter { anime in
            searchFilter(anime: anime)
        }.filter { anime in
            typeFilter(anime: anime)
        }.filter { anime in
           statusFilter(anime: anime)
        }.sorted { firstAnime, secondAnime in
            sorted(firstAnime: firstAnime, secondAnime: secondAnime)
        }
    }
        
    init(persistance:Persistence = .shared) {
        self.persistance = persistance
        do {
            self.animes = try persistance.loadAnimes()
        } catch {
            self.error = CustomErrors.loadDataError.localizedDescription
            self.animes = []
        }
    }
    
    func toggleViewed(anim: AnimeModel) {
        if let index = animes.firstIndex(where: { $0.id == anim.id }) {
            animes[index].isViewed.toggle()

            do {
                try persistance.saveViewedJson(animes: animes)
            } catch {
                self.error = CustomErrors.saveDataError.localizedDescription
            }
        }
    }
    
    func showSimilarAnimes(type: AnimeType, currentAnime:AnimeModel) -> ArraySlice<AnimeModel> {
        animes.filter({ $0.type.rawValue == type.rawValue && $0.id != currentAnime.id }).prefix(8)
    }
    
    func recoverViewedAnimes() -> [AnimeModel] {
        return animes.filter { $0.isViewed }.filter {
            if search.isEmpty {
                return true
            } else {
                return $0.title.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func searchFilter(anime: AnimeModel) -> Bool {
        if search.isEmpty {
            return true
        } else {
            return anime.title.lowercased().contains(search.lowercased())
        }
    }
    
    func showViewedAnimes() -> [AnimeModel] {
        return filteredAnimes.filter { $0.isViewed == true }
    }

    func typeFilter(anime: AnimeModel) -> Bool {
        switch animesType {
        case .ova:
            return anime.type == .ova
        case .pelicula:
            return anime.type == .pelicula
        case .anime:
            return anime.type == .anime
        case .special:
            return anime.type == .special
        case .unknown:
            return true
        }
    }

    func statusFilter(anime: AnimeModel) -> Bool {
        switch animeStatus {
        case .finalizado:
            return anime.status == .finalizado
        case .enEmision:
            return anime.status == .enEmision
        case .proximamente:
            return anime.status == .proximamente
        case .unknown:
            return true
        }
    }
    
    func sorted(firstAnime:AnimeModel, secondAnime:AnimeModel) -> Bool {
        switch sortBy {
        case .title:
            return firstAnime.title <= secondAnime.title
        case .rate:
            return firstAnime.rateStar >= secondAnime.rateStar
        case .year:
            return firstAnime.title < secondAnime.title
        case .all:
            return true
        }
    }
}
