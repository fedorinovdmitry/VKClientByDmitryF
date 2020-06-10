//
//  NetworkService.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(from: API.newsFeed, params: params)
        print(url)
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, responce, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        
        var components = URLComponents()
                
        var allParams = params
        
        allParams["access_token"] = API.token
        allParams["v"] = API.version
        
        components.scheme = API.scheme // это протокол - https://
        components.host = API.host // адрес api.vk.com
        components.path = API.newsFeed // к какому методу мы обращаемся /method/users.get
        
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) } // параметры метода ?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.107

        return components.url!
    }
}
