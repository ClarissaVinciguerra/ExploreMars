//
//  PhotoError.swift
//  ExploreMars
//
//  Created by Clarissa Vinciguerra on 9/23/20.
//

import Foundation

//Change the name of the error
enum PhotoError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case thrownImageError(Error)
    case unableToDecodeImage
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL"
        case .thrownError(let error):
            return "There was an error \(error.localizedDescription)"
        case .noData:
            return "No data found."
        case .thrownImageError(let error):
            return "There was an error \(error.localizedDescription)"
        case .unableToDecodeImage:
            return "There was an error decoding data."
        }
    }
}
