//
//  NetworkDataFetcher.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(responce: @escaping (FeedResponse?) -> Void)
    func getUser(responce: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = data,
            let response = try? decoder.decode(T.self, from: data)
            else { return nil }
        return response
    }
    
    func getFeed(responce: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil)
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            
            responce(decoded?.response)
        }
    }
    
    func getUser(responce: @escaping (UserResponse?) -> Void) {
        guard let userId = API.userId else { return }
        let params = ["fields": "photo_100", "user_ids": userId]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            
            responce(decoded?.response.first)
        }
    }
    
    
    
}
