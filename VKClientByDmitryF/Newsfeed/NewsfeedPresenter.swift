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
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: .displayUser(userViewMode: userViewModel))
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
        
        let photoAttachements = photoAttachments(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachements, isFullSizedPost: isFullSizedPost)
        
        return NewsfeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profilesRepresentable?.photo ?? "",
            name: profilesRepresentable?.name ?? "no name",
            date: DateFormatter.giveRuFormat(date: feedItem.date),
            text: feedItem.text?.replacingOccurrences(of: "<br>", with: "\n"),
            likes: formattedCounter(feedItem.likes?.count),
            comments: formattedCounter(feedItem.comments?.count),
            shares: formattedCounter(feedItem.reposts?.count),
            views: formattedCounter(feedItem.views?.count),
            photoAttachements: photoAttachements,
            sizes: sizes
        )
    }
    
    private func formattedCounter(_ counter: Int?) -> String {
        guard let counter = counter, counter > 0 else { return "" }
        var counterStr = String(counter)
        if (4...6).contains(counterStr.count) {
            counterStr = String(counterStr.dropLast(3)) + "K"
        } else if counterStr.count > 6 {
            counterStr = String(counterStr.dropLast(6)) + "M"
        }
        
        return counterStr
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
    
    private func photoAttachments(feedItem: FeedItem) -> [NewsfeedViewModel.NewsfeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap { (attachment) -> NewsfeedViewModel.NewsfeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return NewsfeedViewModel.NewsfeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG,
                                                                      width: photo.width,
                                                                      height: photo.height)
        }
    }
    
    
}
