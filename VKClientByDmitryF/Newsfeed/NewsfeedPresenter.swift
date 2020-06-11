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

            let feedViewModel = FeedViewModel.init(cells: getCells(from: feed))
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func getCells(from feedResponce: FeedResponse) -> [FeedViewModel.Cell] {
        
        let cells: [FeedViewModel.Cell] = feedResponce.items.map { feedItem in
            let id = feedItem.sourceId
            let profile: ProfileRepresentable? =
                id >= 0 ?
                    feedResponce.profiles.first{ $0.id == id } :
                    feedResponce.groups.first{ $0.id == abs(id) }
            return cellViewModel(from: feedItem, profilesRepresentable: profile)
        }
        return cells
    }
    
    private func cellViewModel(from feedItem: FeedItem, profilesRepresentable: ProfileRepresentable?) -> FeedViewModel.Cell {
        
        return FeedViewModel.Cell.init(
            iconUrlString: profilesRepresentable?.photo ?? "",
            name: profilesRepresentable?.name ?? "no name",
            date: DateFormatter.giveRuFormat(date: feedItem.date),
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0))
    }
}
