//
//  APIClient.swift
//  Catberries
//
//  Created by Илья Черницкий on 6.08.23.
//

import Alamofire
import UIKit
import Foundation

class APIClient {

    private let baseUrl = "dummyjson.com/"

    private func makeUrl(_ method: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.path = baseUrl + method
        return components.url
    }

    func fetchProductsFromAPI(completion: @escaping ([String: [Product]]) -> Void) {
        guard let categoriesUrl = makeUrl("products/categories") else {
            completion([:])
            return
        }

        AF.request(categoriesUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([String].self, from: data)
                    self.fetchProductsForCategories(categories: categories, completion: completion)
                } catch {
                    print("Ошибка декодирования данных категорий: \(error)")
                    completion([:])
                }
            case .failure(let error):
                print("Ошибка получения категорий: \(error)")
                completion([:])
            }
        }
    }

    private func fetchProductsForCategories(categories: [String], completion: @escaping ([String: [Product]]) -> Void) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.dummyjson.fetchProducts", attributes: .concurrent)
        var productsByCategory: [String: [Product]] = [:]

        for category in categories {
            dispatchGroup.enter()

            guard let url = makeUrl("products/category/\(category)") else {
                dispatchGroup.leave()
                continue
            }

            queue.async(group: dispatchGroup) {
                AF.request(url).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let products = try JSONDecoder().decode(ProductResponse.self, from: data)
                            productsByCategory[category] = products.products
                        } catch {
                            print("Ошибка декодирования данных продуктов для категории \(category): \(error)")
                        }
                    case .failure(let error):
                        print("Ошибка получения продуктов для категории \(category): \(error)")
                    }

                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(productsByCategory)
        }
    }
}
