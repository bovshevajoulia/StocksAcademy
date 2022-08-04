//
//  StocksAcademyManager.swift
//  StocksAcademy
//
//  Created by bovsheva on 17.07.2022.
//

import Foundation
import Combine


///Dummy object to manage API calls
final class StocksAcademyManager: StocksAcademyManagerProtocol {
    
    /// Fetch specializations
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Specialization]' data
    public func specializations() -> AnyPublisher<[StocksAcademy.Specialization], Never> {
        
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                promise(.success(StocksAcademy.getSpecializations()))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// Fetch courses for a given specialization
    /// - Parameter specialization: Specialization name
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Course]' data
    public func courses(for specialization: String) -> AnyPublisher<[StocksAcademy.Course], Never> {
        
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                 promise(.success(StocksAcademy.getCourses(for: specialization)))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// Fetch recent courses for user
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Course]' data
    public func recentCourses() -> AnyPublisher<[StocksAcademy.Course], Never> {
        
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                var data = StocksAcademy.financialMarketsCourses()
                data += StocksAcademy.investmentPortfolioManagementCourses()
                data += StocksAcademy.financialManagmentCourses()
                promise(.success(data))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// Fetch modules for a given course
    /// - Parameter course: course name
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Module]' data
    public func modules(for course: String) -> AnyPublisher<[StocksAcademy.Module], Never> {
        
        return Future { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                 promise(.success(StocksAcademy.getModules(for: course)))
            }
        }.eraseToAnyPublisher()
    }
}
