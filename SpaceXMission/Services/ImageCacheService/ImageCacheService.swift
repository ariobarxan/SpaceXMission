//
//  ImageCacheService.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

protocol ImageCacheServiceProtocol {
    func saveImage(_ image: UIImage, withKey key: String)
    
    func fetchImage(withKey key: String) -> UIImage?
}

final class ImageCacheService: ImageCacheServiceProtocol {
    
    static var shared = ImageCacheService()
    
    private let cache = NSCache<NSString, UIImage>()

    func fetchImage(withKey key: String) -> UIImage? {
        let image = cache.object(forKey: key as NSString)
        return image
    }
    
    func saveImage(_ image: UIImage, withKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
