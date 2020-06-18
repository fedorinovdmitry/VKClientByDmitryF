//
//  NewsfeedInteractor.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright (c) 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedNetworkService?
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedNetworkService()
        }
        
        switch request {
            
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (feed, postIds) in
                self?.presenter?.presentData(
                    response: .presentNewsFeed(feed: feed,
                                               revealedPostIds: postIds))
            })
        case .revealPost(let id):
            service?.revealPostIds(forPostId: id,
                                   completion: { [weak self] (feed, revealPostIds) in
                self?.presenter?.presentData(
                    response: .presentNewsFeed(feed: feed,
                                               revealedPostIds: revealPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentData(response: .presentUserInfo(userInfo: user))
            })
        case .getNextBatch:
            print("batch")
            service?.getNextBatch(completion: { [weak self] (feed, postIds) in
                self?.presenter?.presentData(
                    response: .presentNewsFeed(feed: feed,
                                               revealedPostIds: postIds))
            })
        }
        
    }
    
}
