//
//  ProfileAndGroup.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 11.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String {
        return firstName + " " + lastName
    }
    var photo: String {
        return photo100
    }
}

struct Group: Decodable, ProfileRepresentable {

    let id: Int
    let name: String
    let photo100: String
    
    var photo: String {
        return photo100
    }
}
