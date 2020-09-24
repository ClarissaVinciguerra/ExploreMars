//
//  MarsController.swift
//  ExploreMars
//
//  Created by Clarissa Vinciguerra on 9/23/20.
//

import Foundation
import UIKit.UIImage

struct StringConstants {
    fileprivate static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    fileprivate static let curiosityEndpoint = "curiosity"
    fileprivate static let photosEndpoint = "photos"
    fileprivate static let solQueryName = "sol"
    fileprivate static let solQueryValue = "1000"
    fileprivate static let apiKeyQueryName = "api_key"
    fileprivate static let apiKeyQueryValue = "zmAASiO0gYqMzfOGefy9Kkk7gt8UQxMidSHpd9Vf"
}

class MarsController {
    
    static func fetchPhoto(completion: @escaping (Result<Photo, PhotoError>) -> Void) {
        
        //PrepareURL with components and queries
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL))}
        let curiosityURL = baseURL.appendingPathComponent(StringConstants.curiosityEndpoint)
        let photosURL = curiosityURL.appendingPathComponent(StringConstants.photosEndpoint)
        
        var components = URLComponents(url: photosURL, resolvingAgainstBaseURL: true)
        let solQuery = URLQueryItem(name: StringConstants.solQueryName, value: StringConstants.solQueryValue)
        let APIKey = URLQueryItem(name: StringConstants.apiKeyQueryName, value: StringConstants.apiKeyQueryValue)
        components?.queryItems = [solQuery, APIKey]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        //URLSESSION
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let photo = topLevelDictionary.photos[Int.random(in: 1...100)]
                completion(.success(photo))
            } catch {
               return completion(.failure(.noData))
            }
        }.resume()
    }
    
    static func fetchImageFor(photo: Photo, completion: @escaping (Result<UIImage, PhotoError>) -> Void) {
        
        let url = photo.img_src
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return(completion(.failure(.thrownError(error))))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecodeImage)) }
            
            completion(.success(image))
        }.resume()
    }
}//End of Class
