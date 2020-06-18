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
                case revealPost(id: Int)
                case getUser
                case getNextBatch
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
                case presentUserInfo(userInfo: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: NewsfeedViewModel)
                case displayUser(userViewMode: UserViewModel)
            }
        }
    }
    
}

struct NewsfeedViewModel {
    struct Cell: NewsfeedCellViewModel {
        var postId: Int
        
        var iconUrlString: String
        var name: String
        var date: String
        
        var text: String?
        
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        
        var photoAttachements: [NewsfeedCellPhotoAttachmentViewModel]
        
        var sizes: NewsfeedCellSizes
    }
    
    struct NewsfeedCellPhotoAttachment: NewsfeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}
