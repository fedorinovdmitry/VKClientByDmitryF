//
//  NewsfeedModels.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright (c) 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
    
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        var iconUrlString: String
        var name: String
        var date: String
        
        var text: String?
        
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        
    }
    
    let cells: [Cell]
}
