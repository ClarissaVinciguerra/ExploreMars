//
//  Mars.swift
//  ExploreMars
//
//  Created by Clarissa Vinciguerra on 9/23/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    let camera: Camera
    let earth_date: String
    let img_src: URL
    let sol: Int
    
//    enum CodingKeys: String, CodingKey {
//        case earthDate = "earth_date"
//        case image = "img_src"
//    }

    struct Camera: Decodable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "full_name"
        }
    }
}


