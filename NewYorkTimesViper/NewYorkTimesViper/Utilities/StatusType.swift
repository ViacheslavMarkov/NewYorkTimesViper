//
//  StatusType.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 21.07.2023.
//

import Foundation

enum StatusType: String, Decodable {
    case okay  = "OK"
    case error = "ERROR"
}
