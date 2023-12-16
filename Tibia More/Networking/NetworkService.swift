//
//  NetworkService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 15/12/23.
//

import Foundation

final class NetworkService<T: Decodable> {
    
    func fetch(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIErrors.malformedURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(T.self, from: data)
            
            return decoded
        } catch let error as DecodingError {
            print("Some decoding error occured on the network service layer: \(error)")
            throw APIErrors.failedToDecode(error: error)
        } catch {
            print("Some error occured on the network service layer: \(error)")
            throw error
        }
    }
    
}
