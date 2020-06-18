//
//  FeedResponce.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
    
    static func +(lhs:FeedResponse, rhs:FeedResponse) -> FeedResponse {
        var items: [FeedItem] = []
        var profiles: [Profile] = []
        var groups: [Group] = []
        let nextFrom: String? = rhs.nextFrom
        
        items = lhs.items + rhs.items
        
        let filteredProfileRhs = lhs.profiles.filter { (oldProfile) -> Bool in
            !rhs.profiles.contains(where: { $0.id == oldProfile.id})
        }
        profiles = lhs.profiles + filteredProfileRhs
        
        let filteredGroupsRhs = lhs.groups.filter { (oldGroup) -> Bool in
            !rhs.groups.contains(where: { $0.id == oldGroup.id})
        }
        groups = lhs.groups + filteredGroupsRhs
        
        return FeedResponse(items: items, profiles: profiles, groups: groups, nextFrom: nextFrom)
    }
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct CountableItem: Decodable {
    let count: Int
}

struct Attachment: Decodable {
    let photo: Photo? 
}


