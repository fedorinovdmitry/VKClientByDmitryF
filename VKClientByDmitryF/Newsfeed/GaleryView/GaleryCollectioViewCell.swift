//
//  GaleryCollectioViewCell.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 15.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class GaleryCollectioViewCell: UICollectionViewCell {
    
    static let reuseId = "GaleryCollectioViewCell"
    
    let imageView: WebImageView = {
        let imageV = WebImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFill
        imageV.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        //imageView constaints
        imageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    func set(imageUrl: String?) {
        imageView.set(imageURL: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

