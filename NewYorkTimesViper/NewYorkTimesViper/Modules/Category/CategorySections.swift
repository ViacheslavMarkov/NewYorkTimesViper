//
//  CategorySections.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import Foundation

enum CategorySections: CaseIterable {
    case category
    case message
    
    enum Item: Hashable {
        case list(item: CategoryModel)
        case emptyMessage(item: String)
    }
}
