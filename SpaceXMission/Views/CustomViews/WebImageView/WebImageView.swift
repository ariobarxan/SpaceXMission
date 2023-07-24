//
//  WebImage.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

final class WebImageView: UIImageView {
    private var viewModel: WebImageViewModel!
    
    func setup(withURLString urlString: String, name: String){
        viewModel = WebImageViewModel(urlString: urlString) { [unowned self] shouldShowLoading in
            self.showLoading(shouldShowLoading: shouldShowLoading)
        }
        Task {
            await setupImage(name: name)
        }
    }
    
    private func setupImage(name: String) async {
        do {
            let data = try await viewModel.getImageData()
            let image = UIImage(data: data)
            self.image = image
            print("Image downloaded")
        } catch {
            print("Image Error")
            //TODO: - show placeHolder
        }
    }
    
    func showLoading(shouldShowLoading: Bool) {
        
    }
}


