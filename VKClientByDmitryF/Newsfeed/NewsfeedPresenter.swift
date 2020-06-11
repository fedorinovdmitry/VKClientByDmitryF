//
//  NewsfeedPresenter.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright (c) 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(let feed):

            let cells = feed.items.map { cellViewModel(from: $0) }
            let feedViewModel = FeedViewModel.init(cells: cells)
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    
    
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(
            iconUrlString: "",
            name: "future name",
            date: "future date",
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0))
    }
}
