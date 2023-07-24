//
//  BuyLinksData.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct BuyLinksData: Decodable, Hashable {
    let name : String
    let url  : String
    
    init(
        name: String,
        url : String
    ) {
        self.name   = name
        self.url    = url
    }
}
