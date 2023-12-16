//
//  NetworkErrors.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 11/12/23.
//

import Foundation

enum APIErrors: Error {
    case errorOnAPI
    case malformedURL
    case failedToDecode(error: DecodingError)
}
