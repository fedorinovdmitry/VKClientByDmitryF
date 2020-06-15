//
//  NewsfeedCellModels.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 15.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedCellViewModel {
    var iconUrlString: String { get }
    
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    
    var photoAttachement: NewsfeedCellPhotoAttachmentViewModel? { get }
    
    var sizes: NewsfeedCellSizes { get }
}

protocol NewsfeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol NewsfeedCellSizes {
    
    var postLabelFrame: CGRect { get }
    var moreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    
    var totalHeight: CGFloat { get }
}

