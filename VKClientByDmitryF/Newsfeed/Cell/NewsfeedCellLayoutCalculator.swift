//
//  NewsfeedCellLayoutCalculator.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 12.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedCellLayoutCalculator {
    func sizes(postText: String?,
               photoAttachments: [NewsfeedCellPhotoAttachmentViewModel],
               isFullSizedPost: Bool) -> NewsfeedCellSizes
}

final class NewsfeedCellLayoutCalculatorImpl: NewsfeedCellLayoutCalculator {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    struct Sizes: NewsfeedCellSizes {
        var postLabelFrame: CGRect
        var moreTextButtonFrame: CGRect
        var attachmentFrame: CGRect
        
        var totalHeight: CGFloat
    }
    
    func sizes(postText: String?,
               photoAttachments: [NewsfeedCellPhotoAttachmentViewModel],
               isFullSizedPost: Bool) -> NewsfeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - NewsfeedCellConstants.cardViewInsets.left - NewsfeedCellConstants.cardViewInsets.right
        
        // MARK: Work with postLabel Frame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: NewsfeedCellConstants.postLabelInsets.left,
                                                    y: NewsfeedCellConstants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - NewsfeedCellConstants.postLabelInsets.left - NewsfeedCellConstants.postLabelInsets.right
            var height = text.height(width: width, font: NewsfeedCellConstants.postLabelFont)
            
            let limitHeight = NewsfeedCellConstants.postLabelFont.lineHeight * NewsfeedCellConstants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = NewsfeedCellConstants.postLabelFont.lineHeight * NewsfeedCellConstants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Work with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = NewsfeedCellConstants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: NewsfeedCellConstants.moreTextButtonInsets.left,
                                           y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: Work with attachment Frame
        
        let attachY = postLabelFrame.size == CGSize.zero ?
        NewsfeedCellConstants.postLabelInsets.top : moreTextButtonFrame.maxY + NewsfeedCellConstants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: CGFloat(0),
                                                     y: attachY),
                                     size: CGSize.zero)
        
        if let photoAttachment = photoAttachments.first {
            let aspectRatio = CGFloat(photoAttachment.width) / CGFloat(photoAttachment.height)
            if photoAttachments.count == 1 {
                let height = cardViewWidth / aspectRatio
                attachmentFrame.size = CGSize(width: cardViewWidth, height: height)
            } else {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = GalleryRowLayout.rowHeightCounter(superviewWidth: cardViewWidth,
                                                                  photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
                
            }
        }

        // MARK: Work with totalHeight
        
        let totalHeight = max(postLabelFrame.maxY, attachmentFrame.maxY) + NewsfeedCellConstants.bottomViewHeight + NewsfeedCellConstants.cardViewInsets.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     totalHeight: totalHeight)
        
    }
    
    
    
}
