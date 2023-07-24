//
//  ImageCacheManager.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 23.07.2023.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 50 // 50mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
