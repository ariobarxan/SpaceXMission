//
//  WebImageViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

final class WebImageViewModel {
    
    private var urlString: String
    private var repository: WebImageRepositoryProtocol
    private var handleShowLoading: (Bool) -> ()
    
    init(urlString: String,
         repository: WebImageRepositoryProtocol = WebImageRepository(),
         handleShowLoading: @escaping (Bool) -> Void) {
        self.urlString = urlString
        self.repository = repository
        self.handleShowLoading = handleShowLoading
    }
    
    func getImageData() async throws -> Data{
        let imageData = try await repository.fetchImage(withURLString: urlString)
        return imageData
    }
}
