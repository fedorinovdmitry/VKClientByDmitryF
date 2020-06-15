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
        imageV.contentMode = .scaleAspectFit
        imageV.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        //imageView constaints
        imageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func set(imageUrl: String?) {
        imageView.set(imageURL: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

