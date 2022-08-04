//
//  NetworkServiceProtocol.swift
//  StocksAcademy
//
//  Created by bovsheva on 19.06.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    
    /// Fetch data from the REST API server
    /// - Parameter type: 'Codable' data type
    /// - Parameter url: URL string
    /// - Parameter complition: Completion handler
    /// - Returns: 'Void'
    func fetch<T: Codable>(
        _ type: T.Type,
        url: String?,
        complition: @escaping (Result<T,APIError>) -> Void
    )
}
