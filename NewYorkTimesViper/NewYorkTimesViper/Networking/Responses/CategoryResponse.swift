//
//  CategoryResponse.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct CategoryResponse: Decodable {
    let status          : StatusType
    let numberOfResults : Int
    let results         : OverviewData
    
    enum CodingKeys: String, CodingKey {
        case status
        case results
        case numberOfResults = "num_results"
    }
}
