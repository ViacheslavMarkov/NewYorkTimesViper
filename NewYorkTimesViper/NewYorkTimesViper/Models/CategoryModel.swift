//
//  CategoryModel.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

struct CategoryModel: Identifiable, Hashable {
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    
    let date: String
    let category: OverviewDescriptionData
}
