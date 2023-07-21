//
//  OverviewData.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct OverviewData: Decodable {
    let publishedDate   : String
    let lists           : [OverviewDescriptionData]
    
    enum CodingKeys: String, CodingKey {
        case lists
        case publishedDate = "published_date"
    }
    
    init(
        publishedDate: String,
        lists        : [OverviewDescriptionData]
    ) {
        self.publishedDate  = publishedDate
        self.lists          = lists
    }
}
