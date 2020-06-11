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
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
            
        case .getNewsFeed:
            fetcher.getFeed { [weak self] (feedResponce) in
                guard
                    let feedResponce = feedResponce,
                    let self = self
                    else { return }
                
                self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponce))
            }
        }
    }
    
}
