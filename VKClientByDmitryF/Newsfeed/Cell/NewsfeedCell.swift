//
//  NewsfeedCell.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 11.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    
    var photoAttachement: FeedCellPhotoAttachmentViewModel? { get }
    
    var sizes: FeedCellSizes { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}



class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postLabel.sizeToFit()
    }
    
    func set(viewModel: FeedCellViewModel) {
        
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        
        
        configPostLabel(with: viewModel.text, and: viewModel.sizes.postLabelFrame)
        configPostImageView(with: viewModel.photoAttachement, and: viewModel.sizes.attachmentFrame)
        

        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
    
    private func configPostLabel(with text: String?, and frame: CGRect) {
        postLabel.text = text
        postLabel.frame = frame
    }
    
    private func configPostImageView(with photoAttachment: FeedCellPhotoAttachmentViewModel?, and frame: CGRect) {
        if let photoAttachment = photoAttachment {
            postImageView.isHidden = false
            postImageView.set(imageURL: photoAttachment.photoUrlString)
        } else {
            postImageView.isHidden = true
        }
        postImageView.frame = frame
    }
}
