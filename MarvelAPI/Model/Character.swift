//
//  Character.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 04/06/23.
//

import Foundation
import SwiftUI

struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
