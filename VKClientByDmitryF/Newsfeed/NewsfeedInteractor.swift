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
    var service: NewsfeedService?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    private var feedResponce: FeedResponse?
    private var revealPostIds = [Int]()
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self] (feedResponce) in
                guard let self = self else { return }
                self.feedResponce = feedResponce
                self.presentFeed()
            }
        case .revealPost(let postId):
            revealPostIds.append(postId)
            presentFeed()
        case .getUser:
            fetcher.getUser { [weak self] (userResponce) in
                self?.presenter?.presentData(response: .presentUserInfo(userInfo: userResponce))
            }
        }
        
    }
    private func presentFeed() {
        guard let feedResponce = feedResponce else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponce, revealedPostIds: revealPostIds))
    }
    
}
