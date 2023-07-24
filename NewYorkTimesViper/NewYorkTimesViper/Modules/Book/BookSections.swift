//
//  BookSections.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import Foundation

enum BookSections: CaseIterable {
    case book
    
    enum Item: Hashable {
        case list(item: BookData)
    }
}
