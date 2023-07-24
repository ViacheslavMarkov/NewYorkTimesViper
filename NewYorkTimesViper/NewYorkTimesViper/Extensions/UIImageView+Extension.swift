//
//  UIImageView+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

extension UIImageView {
    func imageFromServerURLWithCompletion(
        urlString: String,
        completion: ((_ image: UIImage?) -> ())? = nil
    ) {
        image = nil
        guard let url = URL(string: urlString) else { return }
        
        if let image = ImageCacheManager.shared.get(key: urlString) {
            self.image = image
            completion?(image)
            return
        }
        
        Task {
            do {
                let data = try await downloadImageData(from: url)
                guard
                    let image = UIImage(data: data) else {
                    completion?(nil)
                    return }
                self.image = image
                ImageCacheManager.shared.add(key: urlString, value: image)
                completion?(image)
            } catch {
                print("Error: \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
    
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
