//
//  WebImageRepositroy.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

protocol WebImageRepositoryProtocol {
    func fetchImage(withURLString urlString: String) async throws -> Data
}

final class WebImageRepository: WebImageRepositoryProtocol {
    private var imageData: Data!
    
    func fetchImage(withURLString urlString: String) async throws -> Data {
        let imageData = try await WebService.shared.fetchImageData(withURLString: urlString)
        
        return imageData
    }
    
}
