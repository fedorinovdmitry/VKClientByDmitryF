//
//  TitleView.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 17.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit
protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}
class TitleView: UIView {
    
    private var myTextField = InsertableTextField()
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    
    private func makeConstraints() {
        addSubviews(views: [myTextField, myAvatarView])
        
        
        // myTextField constraints
        myTextField.anchor(top: self.topAnchor,
                           leading: self.leadingAnchor,
                           bottom: self.bottomAnchor,
                           trailing: myAvatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
        
        
        // myAvatarView constraints
        myAvatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
}
