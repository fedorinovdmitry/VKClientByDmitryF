//
//  NewsfeedCellLayoutCalculator.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 12.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - NewsfeedCellConstants.cardViewInsets.left - NewsfeedCellConstants.cardViewInsets.right
        
        // MARK: Work with postLabel Frame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: NewsfeedCellConstants.postLabelInsets.left,
                                                    y: NewsfeedCellConstants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - NewsfeedCellConstants.postLabelInsets.left - NewsfeedCellConstants.postLabelInsets.right
            let height = text.height(width: width, font: NewsfeedCellConstants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Work with attachment Frame
        
        let attachY = postLabelFrame.size == CGSize.zero ?
        NewsfeedCellConstants.postLabelInsets.top : postLabelFrame.maxY + NewsfeedCellConstants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: CGFloat(0),
                                                     y: attachY),
                                     size: CGSize.zero)
        
        if let photoAttachment = photoAttachment {
            let aspectRatio = CGFloat(photoAttachment.width) / CGFloat(photoAttachment.height)
            let height = cardViewWidth / aspectRatio
            attachmentFrame.size = CGSize(width: cardViewWidth, height: height)
        }

        // MARK: Work with totalHeight
        
        let totalHeight = max(postLabelFrame.maxY, attachmentFrame.maxY) + NewsfeedCellConstants.bottomViewHeight + NewsfeedCellConstants.cardViewInsets.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     totalHeight: totalHeight)
        
    }
    
    struct Sizes: FeedCellSizes {
        var postLabelFrame: CGRect
        var attachmentFrame: CGRect
        
//        var bottomViewFrame: CGRect
        var totalHeight: CGFloat
    }
    
}
