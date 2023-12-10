//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Antony Huaman Alikhan on 8/12/23.
//

import Foundation


struct PokemonData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}

