//
//  OverviewDescriptionData.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct OverviewDescriptionData: Decodable, Hashable {
    let listId      : Int
    let displayName : String
    let books       : [BookData]
    
    enum CodingKeys: String, CodingKey {
        case listId         = "list_id"
        case displayName    = "display_name"
        case books
    }
    
    init(
        listId      : Int,
        displayName : String,
        books       : [BookData]
    ) {
        self.listId      = listId
        self.displayName = displayName
        self.books       = books
    }
}
