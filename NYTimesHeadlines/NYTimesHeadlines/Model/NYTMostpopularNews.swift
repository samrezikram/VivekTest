//
//  RootClass.swift
//  Created on May 2, 2021

import Foundation

struct NYTMostpopularNews : Codable {

    let copyright : String?
    let numResults : Int?
    let results : [Result]
    let status : String?

    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        numResults = try values.decodeIfPresent(Int.self, forKey: .numResults)
        results = try values.decodeIfPresent([Result].self, forKey: .results) ?? [Result].init()
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
