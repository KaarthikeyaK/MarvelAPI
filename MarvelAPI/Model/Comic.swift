//
//  Comics.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 07/06/23.
//

import Foundation

struct APIComicResult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var issueNumber: Double
    var description: String?
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
