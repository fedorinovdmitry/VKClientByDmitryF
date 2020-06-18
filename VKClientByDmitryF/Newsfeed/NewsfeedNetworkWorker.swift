//
//  NewsfeedNetworkWorker.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright (c) 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class NewsfeedNetworkService {

    // MARK: - Custom types
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let fetcher: DataFetcher
    
    private var feedResponse: FeedResponse?
    private var revealPostIds = [Int]()
    
    private var newFromInProcess: String?
    
    // MARK: - Init
    
    init() {
        let networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    // MARK: - Public methods
    
    func getUser(completion: @escaping (UserResponse) -> Void) {
        fetcher.getUser { (userResponse) in
            guard let userResponse = userResponse else { return }
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping (FeedResponse, [Int]) -> Void) {
        fetcher.getFeed { [weak self] (feedResponse) in
            guard let self = self else { return }
            self.feedResponse = feedResponse
            guard let feedResponse = self.feedResponse else { return }
            completion(feedResponse, self.revealPostIds)
        }
    }
    
    func revealPostIds(forPostId postId: Int,
                       completion: @escaping (FeedResponse, [Int]) -> Void) {
        revealPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(feedResponse, revealPostIds)
    }
    
    func getNextBatch(completion: @escaping (FeedResponse, [Int]) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(withNextBatchFrom: newFromInProcess) { [weak self] (feedResponse) in
            guard
                let self = self,
                let newFeedResponse = feedResponse,
                let oldFeedResponse = self.feedResponse
                else { return }
            let completedFeedResponse = oldFeedResponse + newFeedResponse
            self.feedResponse = completedFeedResponse
            
            completion(completedFeedResponse, self.revealPostIds)
        }
    }
    
    // MARK: - Private methods
    
}
