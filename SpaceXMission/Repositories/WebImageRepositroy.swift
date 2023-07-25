//
//  WebImageRepositroy.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

protocol WebImageRepositoryProtocol {
    func fetchImage(withURLString urlString: String) async throws -> Data
}

final class WebImageRepository: WebImageRepositoryProtocol {
    private var imageData: Data!
    private let imageCacheService = ImageCacheService.shared
    private var image: UIImage? = nil

    func fetchImage(withURLString urlString: String) async throws -> Data {
        if let image = imageCacheService.fetchImage(withKey: urlString) {
            self.imageData = image.pngData()
            return imageData
        }
        let imageData = try await WebService.shared.fetchImageData(withURLString: urlString)
        self.imageData = imageData
        image = UIImage(data: imageData)
        if let image = image {
            self.imageCacheService.saveImage(image, withKey: urlString)
        }
        return imageData
    }
}
