//
//  StocksAcademyManagerProtocol.swift
//  StocksAcademy
//
//  Created by bovsheva on 29.07.2022.
//
import Foundation
import Combine

/// Protocol to manage API calls
protocol StocksAcademyManagerProtocol {
    
    /// Fetch specializations
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Specialization]' data
    func specializations() -> AnyPublisher<[StocksAcademy.Specialization], Never>
    
    /// Fetch courses for a given specialization
    /// - Parameter specialization: Specialization name
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Course]' data
    func courses(for specialization: String) -> AnyPublisher<[StocksAcademy.Course], Never>
    
    /// Fetch recent courses for user
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Course]' data
    func recentCourses() -> AnyPublisher<[StocksAcademy.Course], Never>
    
    /// Fetch modules for a given course
    /// - Parameter course: course name
    /// - Returns: 'AnyPublisher' type with '[StocksAcademy.Module]' data
    func modules(for course: String) -> AnyPublisher<[StocksAcademy.Module], Never>
}
