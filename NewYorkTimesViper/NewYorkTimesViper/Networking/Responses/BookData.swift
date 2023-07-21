//
//  BookData.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct BookData: Decodable, Identifiable, Hashable {
    let id = UUID().uuidString
    
    let imageUrlString   : String
    let author           : String
    let description      : String
    let rank             : Int
    let publisher        : String
    let buyLinks         : [BuyLinksData]
    
    enum CodingKeys: String, CodingKey {
        case imageUrlString = "book_image"
        case author
        case description
        case rank
        case publisher
        case buyLinks       = "buy_links"
    }
    
    init(
        imageUrlString  : String,
        author          : String,
        description     : String,
        rank            : Int,
        publisher       : String,
        buyLinks        : [BuyLinksData]
    ) {
        self.imageUrlString = imageUrlString
        self.author         = author
        self.description    = description
        self.rank           = rank
        self.publisher      = publisher
        self.buyLinks       = buyLinks
    }
}
