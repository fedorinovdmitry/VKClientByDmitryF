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
    var cellLayoutCalculator: NewsfeedCellLayoutCalculator = NewsfeedCellLayoutCalculatorImpl()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(let feed, let postId):

            let feedViewModel = NewsfeedViewModel.init(cells: getCells(from: feed, with: postId))
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func getCells(from feedResponce: FeedResponse, with revealPostIds: [Int]) -> [NewsfeedViewModel.Cell] {
        
        let cells: [NewsfeedViewModel.Cell] = feedResponce.items.map { feedItem in
            let id = feedItem.sourceId
            let profile: ProfileRepresentable? =
                id >= 0 ?
                    feedResponce.profiles.first{ $0.id == id } :
                    feedResponce.groups.first{ $0.id == abs(id) }
            
            let isFullSized = revealPostIds.contains(feedItem.postId)
            
            return cellViewModel(from: feedItem, profilesRepresentable: profile, isFullSizedPost: isFullSized)
        }
        return cells
    }
    
    private func cellViewModel(from feedItem: FeedItem, profilesRepresentable: ProfileRepresentable?, isFullSizedPost: Bool) -> NewsfeedViewModel.Cell {
        
        let photoAttachement = photoAttachment(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachement, isFullSizedPost: isFullSizedPost)
        
        return NewsfeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profilesRepresentable?.photo ?? "",
            name: profilesRepresentable?.name ?? "no name",
            date: DateFormatter.giveRuFormat(date: feedItem.date),
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachement: photoAttachement,
            sizes: sizes
        )
    }
    
    private func photoAttachment(feedItem: FeedItem) -> NewsfeedViewModel.NewsfeedCellPhotoAttachment? {
        guard
            let photos = feedItem.attachments?.compactMap({ $0.photo }),
            let firstPhoto = photos.first
        else {
            return nil
        }
        return NewsfeedViewModel.NewsfeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    
    
}
