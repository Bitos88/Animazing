//
//  AnimeModel.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import Foundation

struct AnimeModel: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String?
    let year: Int
    let type: AnimeType
    let rateStar: String
    let votes: Int
    let status: AnimeStatus
    var followers: Int
    let episodes: Int
    let animeURL: String
    let image: String
    let genres: String?
    var isViewed:Bool
    
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes, genres, image, isViewed
        case animeURL = "url_anime"
        case rateStar = "rate_start"
    }
}

enum AnimeStatus:String, Codable {
    case finalizado = "Finalizado"
    case enEmision = "En emision"
    case proximamente = "Próximamente"
    case unknown
    
    func correctFormat() -> String {
        switch self {
        case .finalizado:
            return "Finalizado"
        case .enEmision:
            return "En emisión"
        case .proximamente:
            return "Próximamente"
        case .unknown:
            return ""
        }
    }
}

enum AnimeType:String, CaseIterable, Identifiable, Codable {
    var id: AnimeType { self }
    case anime = "Anime"
    case special = "Especial"
    case ova = "OVA"
    case pelicula = "Película"
    case unknown = "All"
}

enum SortBy:String, CaseIterable, Identifiable {
    var id: SortBy { self }
    case title = "Title"
    case rate = "Rate"
    case year = "Year"
    case all = "All"
}

enum AnimeGenres:String, CaseIterable, Identifiable {
    var id: AnimeGenres { self }
    case adventures = "Aventuras"
    case scifi = "Ciencia Ficción"
    case comedy = "Comedy"
    case history = "Historico"
    case romance = "Romance"
    case fantasy = "Fantasia"
    case shounen = "Shounen"
    case magic = "Magia"
    case sobrenatural = "Sobrenatural"
    case ecchi = "Ecchi"
    case harem = "Harem"
    case seinen = "Seinen"
    case suspense = "Suspenso"
    case drama = "Drama"
    case demons = "Demons"
    case mecha = "Mecha"
    case space = "Espacial"
    case militar = "Militar"
    case police = "Policía"
    case school = "Escolares"
    case martialArts = "Artes Marciales"
    case others = "Otros"
}

extension JSONAnimeModel {
    func mapToModel() -> AnimeModel {
        return AnimeModel(title: title,
                          description: description,
                          year: year,
                          type: AnimeType(rawValue: type) ?? .unknown,
                          rateStar: rateStar,
                          votes: votes,
                          status: AnimeStatus(rawValue: status) ?? .unknown,
                          followers: followers,
                          episodes: episodes,
                          animeURL: animeURL,
                          image: image,
                          genres: genres,
                          isViewed: false)
    }
}

