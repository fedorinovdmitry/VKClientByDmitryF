//
//  NewsfeedCellConstants.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 13.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

struct NewsfeedCellConstants {
    
    static let cardViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    
    static let topViewHeight: CGFloat = 54
    static let iconImageSize: CGFloat = topViewHeight
    
    static let postLabelInsets = UIEdgeInsets(top: 3 + topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    
    static let bottomViewHeight: CGFloat = 46
    static let bottomViewViewSize: CGSize = CGSize(width: 80, height: bottomViewHeight)
    static let bottomViewViewsIconSize: CGSize = CGSize(width: 24, height: 24)
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
}
