//
//  UserResponse.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 17.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
