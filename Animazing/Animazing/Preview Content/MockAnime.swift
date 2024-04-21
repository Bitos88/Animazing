//
//  MockAnime.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import Foundation

struct FilePreview:FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "MockAnime", withExtension: "json")!
    }
}

extension AnimeModel {
    static let test = AnimeModel(title: "Umezu Kazuo no Noroi",
                                 description: "Dos Historias separadas. En la primera titulada \"Qué revelara la camara de video\", una estudiante de intercambio llega de México causando gran agitación en la vida de una compañera de clase llamada Masami. En la segunda historia titulada \"La mansion embrujada\", cuatro niñas en una aventura en una siniestra casa.",
                                 year: 1990,
                                 type: .ova,
                                 rateStar: "3.4",
                                 votes: 38,
                                 status: .finalizado,
                                 followers: 136,
                                 episodes: 1,
                                 animeURL: "https://www3.animeflv.net/anime/umezu-kazuo-no-noroi",
                                 image: "https://www3.animeflv.net/uploads/animes/covers/2299.jpg",
                                 genres: "Aventura, Drama",
                                 isViewed: true)
}

extension AnimeListVM {
    static let preview = AnimeListVM(persistance: Persistence(fileLocation: FilePreview()))
}
