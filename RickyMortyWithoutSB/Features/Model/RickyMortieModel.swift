//
//  RickyMortieModel.swift
//  RickyMortyWithoutSB
//
//  Created by Muhammet  on 12.06.2022.
//

import Foundation
// MARK: - PostModel
struct PostModel: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result:Codable {
    let name: String?
    let status: String?
    let image: String?
}
