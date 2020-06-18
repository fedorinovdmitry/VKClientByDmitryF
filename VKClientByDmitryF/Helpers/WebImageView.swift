//
//  WebImageView.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 11.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            if image == nil {
                image = UIImage(named: "noPhoto")
            }
        }
    }
    
    private var  currentUrl: String?
    
    func set(imageURL: String?) {
        currentUrl = imageURL
        guard
            let imageURL = imageURL,
            let url = URL(string: imageURL)
            else {
                self.image = nil
                return
        }
        
        if let cashedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cashedResponse.data)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response, let self = self {
                    self.handleLoadedImage(data: data, response: response)
                }
            }
        }.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cashedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentUrl {
            self.image = UIImage(data: data)
        }
    }
}
