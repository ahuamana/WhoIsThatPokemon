//
//  ImageData.swift
//  who is that pokemon
//
//  Created by Antony Huaman Alikhan on 8/12/23.
//

import Foundation


// MARK: - PokemonData
struct ImageData: Codable {
    let sprites: Sprites?
}

// MARK: - Sprites
class Sprites: Codable {

    let other: Other?

    init(other: Other?) {
        self.other = other
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
