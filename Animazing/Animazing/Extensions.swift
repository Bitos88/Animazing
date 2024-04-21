//
//  Extensions.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import Foundation

extension JSONDecoder {
    static let withDateFormatter = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }()
}

extension JSONEncoder {
    static let withPrettyPrinted = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        return encoder
    }()
}

enum CustomErrors:Error {
    case parseDataError
    case loadDataError
    case saveDataError
}

extension String {
    func withFormmat() -> String {
        return self.replacingOccurrences(of: ",", with: ", ")
    }
}
