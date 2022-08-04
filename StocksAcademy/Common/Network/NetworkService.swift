//
//  NetworkManager.swift
//  StocksAcademy
//
//  Created by bovsheva on 16.06.2022.
//

import Foundation


struct NetworkService: NetworkServiceProtocol {
    
    
    /// Fetch data from the REST API server
    /// - Parameter type: 'Codable' data type
    /// - Parameter url: URL string
    /// - Parameter complition: Completion handler
    /// - Returns: 'Void'
    func fetch<T: Codable>(
        _ type: T.Type,
        url: String?,
        complition: @escaping (Result<T,APIError>) -> Void
        
    ) {
        
        guard let url = url , let requestUrl = URL(string: url) else {
            complition(.failure(APIError.badUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            
            if let error = error as? URLError {
                
                complition(.failure(APIError.urlSessionError(error)))
                
            } else if let response = response as? HTTPURLResponse,
                      !(200...299).contains(response.statusCode) {
                
                complition(.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let value = try decoder.decode(type, from: data)
                    complition(.success(value))
                    
                } catch {
                    complition(.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
}
