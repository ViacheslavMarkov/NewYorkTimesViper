//
//  GenericError.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

protocol ErrorConforming: LocalizedError, CustomStringConvertible {
    var description: String { get }
    var errorDescription: String { get }
}

struct GenericError: ErrorConforming {
    let message: String
    let detailedDescription: String?
    
    var description: String {
        message
    }
    
    var errorDescription: String {
        if let detailedDescription = detailedDescription {
            let errorMessage = "Error: \(message)"
            let detailedDescription = "Detailed description:\(detailedDescription)"
            return "\(errorMessage)\n\(detailedDescription)"
        } else {
            return "Error: \(message)"
        }
    }
    
    init(
        message: String,
        detailedDescription: String? = nil
    ) {
        self.message = message
        self.detailedDescription = detailedDescription
    }
}
