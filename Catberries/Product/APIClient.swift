//
//  Product.swift
//  Catberries
//
//  Created by Илья Черницкий on 1.08.23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case wrongDataRequest
    case wrongStatusCode
    case wrongUrl
    
    var errorDescription: String? {
        switch self {
        case .wrongDataRequest:
            return "Неудалось распарсить данные"
            
        case .wrongStatusCode:
            return "Неуспешный код ответа"
            
        case .wrongUrl:
            return "Неправильный URL"
        }
    }
}

struct ProductResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
