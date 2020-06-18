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
        let layout = GalleryRowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.delegate = self
        
        delegate = self
        dataSource = self
        register(GaleryCollectioViewCell.self, forCellWithReuseIdentifier: GaleryCollectioViewCell.reuseId)
        backgroundColor = UIColor.white
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func set(photos: [NewsfeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

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

// MARK: - RowLayoutDelegate

extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAt indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        
        return CGSize(width: width, height: height)
    }
    
}
