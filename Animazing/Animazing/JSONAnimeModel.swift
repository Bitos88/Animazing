//
//  AnimeModel.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import Foundation

struct JSONAnimeModel: Codable, Hashable {
    let title: String
    let description: String?
    let year: Int
    let type: String
    let rateStar: String
    let votes: Int
    let status: String
    let followers: Int
    let episodes: Int
    let animeURL: String
    let image: String
    let genres: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes, genres, image
        case animeURL = "url_anime"
        case rateStar = "rate_start"
    }
}
