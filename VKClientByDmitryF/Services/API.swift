//
//  API.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.107"
    
    static let newsFeed = "/method/newsfeed.get"
    
    static let token = SceneDelegate.shared().authService.token
}
