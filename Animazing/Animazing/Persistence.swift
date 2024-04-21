//
//  Persistence.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import Foundation

protocol FileLocation {
    var fileURL:URL { get }
}

struct FileProduction: FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "anime", withExtension: "json")!
    }
}

final class Persistence {
    static let shared = Persistence()
    
    let viewedAnimesDocumentURL = URL.documentsDirectory.appending(path: "viewedAnimes.json")
    var fileLocation:FileLocation
    
    init(fileLocation:FileLocation = FileProduction()) {
        self.fileLocation = fileLocation
    }
    
    func loadAnimes() throws -> [AnimeModel] {
        let decoder = JSONDecoder.withDateFormatter
        
        if FileManager.default.fileExists(atPath: viewedAnimesDocumentURL.path()) {
            let data = try Data(contentsOf: viewedAnimesDocumentURL)
            return try decoder.decode([AnimeModel].self, from: data)
        } else {
            let data = try Data(contentsOf: fileLocation.fileURL)
            let myRealData = try decoder.decode([JSONAnimeModel].self, from: data)
            let myLocalData = myRealData.map { $0.mapToModel() }
            let localData = try JSONEncoder().encode(myLocalData)
            try localData.write(to: viewedAnimesDocumentURL, options: .atomic)
            
            return try JSONDecoder().decode([AnimeModel].self, from: localData)
        }
    }
    
    func saveViewedJson(animes: [AnimeModel]) throws {
        let enconder = JSONEncoder.withPrettyPrinted
        
        let savedData = try enconder.encode(animes)
        try savedData.write(to: viewedAnimesDocumentURL)
    }
}
