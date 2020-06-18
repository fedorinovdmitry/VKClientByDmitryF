//
//  NetworkDataFetcher.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getFeed(withNextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
    
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
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        fetchFeed(with: params, and: response)
    }
    
    func getFeed(withNextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        guard let nextBatchFrom = withNextBatchFrom else { return }
        let params = ["filters": "post,photo", "start_from": nextBatchFrom]
        fetchFeed(with: params, and: response)
    }
    
    private func fetchFeed(with params: [String : String], and response: @escaping (FeedResponse?) -> Void) {
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = API.userId else { return }
        let params = ["fields": "photo_100", "user_ids": userId]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            
            response(decoded?.response.first)
        }
    }
    
    
    
}
