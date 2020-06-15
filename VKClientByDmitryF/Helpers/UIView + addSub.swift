//
//  UIView + addSub.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 13.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(views: [UIView]) {
        views.forEach{ self.addSubview($0) }
    }
    
}

