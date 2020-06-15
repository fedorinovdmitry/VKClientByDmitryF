//
//  GalleryCollectionView.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 15.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    var photos = [NewsfeedCellPhotoAttachmentViewModel]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(GaleryCollectioViewCell.self, forCellWithReuseIdentifier: GaleryCollectioViewCell.reuseId)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    func set(photos: [NewsfeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GaleryCollectioViewCell.reuseId, for: indexPath) as! GaleryCollectioViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
}
