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
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsFeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsFeed
            }
        }
    }
    
}
