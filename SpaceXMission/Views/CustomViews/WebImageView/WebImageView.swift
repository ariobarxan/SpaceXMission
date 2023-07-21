//
//  WebImage.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

final class WebImageView: UIImageView {
    private var viewModel: WebImageViewModel!
    
    func setup(withURLString urlString: String){
        viewModel = WebImageViewModel(urlString: urlString) { [unowned self] shouldShowLoading in
            self.showLoading(shouldShowLoading: shouldShowLoading)
        }
        Task {
            await setupImage()
        }
    }
    
    private func setupImage() async {
        do {
            let data = try await viewModel.getImageData()
            let image = UIImage(data: data)
            self.image = image
        } catch {
            //TODO: - show placeHolder
        }
    }
    
    func showLoading(shouldShowLoading: Bool) {
        
    }
}


