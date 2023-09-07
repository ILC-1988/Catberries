//
//  UIImageView.swift
//  Catberries
//
//  Created by Илья Черницкий on 19.08.23.
//

import UIKit

// MARK: setImage
extension UIImageView {
    func setImage(_ url: URL?) {
        guard let url = url else {
            image = nil
            return
        }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self?.image = UIImage(data: data)
                } else {
                    self?.image = nil
                }
            }
        }
        downloadTask.resume()
    }
}
