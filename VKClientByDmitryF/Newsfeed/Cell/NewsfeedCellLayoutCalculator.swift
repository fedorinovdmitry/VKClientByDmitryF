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
    
    struct Constants {
        static let cardViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        static let topViewHeight: CGFloat = 44
        static let postLabelInsets = UIEdgeInsets(top: 3 + topViewHeight + 8, left: 8, bottom: 8, right: 8)
        static let postLabelFont = UIFont.systemFont(ofSize: 15)
        static let bottomViewHeight: CGFloat = 46
    }
    
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardViewInsets.left - Constants.cardViewInsets.right
        
        // MARK: Work with postLabel Frame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Work with attachment Frame
        
        let attachY = Constants.postLabelInsets.top + postLabelFrame.height + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: CGFloat(0),
                                                     y: attachY),
                                     size: CGSize.zero)
        
        if let photoAttachment = photoAttachment {
            let widthPhoto = photoAttachment.width
            let aspectRatio = CGFloat(widthPhoto) / cardViewWidth
            let height = CGFloat(photoAttachment.height) / aspectRatio
            attachmentFrame.size = CGSize(width: cardViewWidth, height: height)
        }
        
        // MARK: Work with bottomView Frame
        
        let bottomViewFrame = CGRect(x: CGFloat(0), y: attachY + attachmentFrame.height, width: cardViewWidth, height: Constants.bottomViewHeight)
        
        let totalHeight = attachY + attachmentFrame.height + Constants.bottomViewHeight + Constants.cardViewInsets.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
        
    }
    
    struct Sizes: FeedCellSizes {
        var postLabelFrame: CGRect
        var attachmentFrame: CGRect
        
        var bottomViewFrame: CGRect
        var totalHeight: CGFloat
    }
    
}
