//
//  NetworkService.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

class NetworkService {
// "https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.107"
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
        var components = URLComponents()
        
        guard let token = authService.token else { return }
        
//        let params = ["filters": "post,photo"]
        var allParams = ["filters": "post,photo"]
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        components.scheme = API.scheme // это протокол - https://
        components.host = API.host // адрес api.vk.com
        components.path = API.newsFeed // к какому методу мы обращаемся /method/users.get
        
        
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) } // параметры метода ?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.107
        
        let url = components.url
        print(url!)
    }
}
