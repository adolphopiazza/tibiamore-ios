//
//  NetworkService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 15/12/23.
//

import Foundation

final class NetworkService<T: Decodable> {
    
    func fetch(baseURL: String = .tibiaDataURL, url: String) async throws -> T {
        #if DEBUG
        print("We are fetching with debug mode, dev API, endpoint -> \(url)")
        #else
        print("We are fetching with release mode, prod API, endpoint -> \(url)")
        #endif
        
        guard let url = URL(string: baseURL + url) else {
            throw APIErrors.malformedURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpCode = response as? HTTPURLResponse, 500...599 ~= httpCode.statusCode {
                throw APIErrors.serverError(httpCode: httpCode.statusCode)
            }
            
            if baseURL != .tibiaLabsURL {
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(T.self, from: data)
                
                return decoded
            } else {
                // TibiaLabs API always return a String, so we convert right here
                guard let decodedString = String(data: data, encoding: .utf8) else {
                    throw APIErrors.failedToDecodeString
                }
                
                // Should not fail because it's always a string, but idk let's see
                return decodedString as! T
            }
        } catch let error as DecodingError {
            print("Some decoding error occured on the network service layer: \(error)")
            throw APIErrors.failedToDecode(error: error)
        } catch {
            print("Some error occured on the network service layer: \(error)")
            throw error
        }
    }
    
}
