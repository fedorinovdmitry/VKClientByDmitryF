//
//  NewsfeedCodeCell.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 12.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
        overlayFourthLayer()
        
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //для того чтобы ячейки при перелистовывании были пустыми
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    @objc private func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    // MARK: - Setup Cell
    
    func set(viewModel: NewsfeedCellViewModel) {
        
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        
        configPostLabel(with: viewModel.text, and: viewModel.sizes.postLabelFrame)
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        configPostImageView(with: viewModel.photoAttachements, and: viewModel.sizes.attachmentFrame)
        
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
    
    private func configPostLabel(with text: String?, and frame: CGRect) {
        postLabel.text = text
        postLabel.frame = frame
    }
    
    private func configPostImageView(with photoAttachments: [NewsfeedCellPhotoAttachmentViewModel], and frame: CGRect) {
        if let photoAttachment = photoAttachments.first, photoAttachments.count == 1 {
            postImageView.isHidden = false
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.frame = frame
            galeryCollectionView.isHidden = true
        } else if photoAttachments.count > 1 {
            galeryCollectionView.frame = frame
            postImageView.isHidden = true
            galeryCollectionView.isHidden = false
            galeryCollectionView.set(photos: photoAttachments)
        } else {
            postImageView.isHidden = true
            galeryCollectionView.isHidden = true
        }
        
    }
    
    // MARK: - First layer

    // MARK: Elements:

    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Constraints:

    private func overlayFirstLayer() {
        addSubview(cardView)
        
        // cardView constraints
        cardView.fillSuperview(padding: NewsfeedCellConstants.cardViewInsets)
    }
    
    
    // MARK: - Second layer
    
    // MARK: Elements:
    
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = NewsfeedCellConstants.postLabelFont
        label.textColor = #colorLiteral(red: 0.1764705882, green: 0.1803921569, blue: 0.1764705882, alpha: 1)
        return label
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let galeryCollectionView = GalleryCollectionView()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Constraints:
    
    private func overlaySecondLayer() {
        
        cardView.addSubviews(views: [topView,
                                     postLabel,
                                     moreTextButton,
                                     galeryCollectionView,
                                     postImageView,
                                     bottomView])
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 3).isActive = true
        topView.heightAnchor.constraint(equalToConstant: NewsfeedCellConstants.topViewHeight).isActive = true
        
        // postLabel constraints
        // this view support autosizing ... look in NewsfeedCellLayoutCalculatorImpl
        
        // moreTextButton constraints
        // this view support autosizing ... look in NewsfeedCellLayoutCalculatorImpl
        
        // galeryCollectionView constraints
        // this view support autosizing ... look in NewsfeedCellLayoutCalculatorImpl
        
        // postImageView constraints
        // this view support autosizing ... look in NewsfeedCellLayoutCalculatorImpl
    
        // bottomView constraints
        bottomView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: NewsfeedCellConstants.bottomViewHeight).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
        
        
    }

    // MARK: - Third layer
    
    // MARK: TopView's childs:

    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = NewsfeedCellConstants.iconImageSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1764705882, green: 0.1803921569, blue: 0.1764705882, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 12)
       label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
       return label
    }()
    
    private func overlayThirdLayerOnTopView() {
        
        topView.addSubviews(views: [iconImageView,
                                    nameLabel,
                                    dateLabel])
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.anchorSize(withConstant: NewsfeedCellConstants.iconImageSize,
                                 heightConstant: NewsfeedCellConstants.iconImageSize)
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 3).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: NewsfeedCellConstants.iconImageSize / 2 - 2).isActive = true
        
        // dateLabel constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -3).isActive = true
        
    }
    
    // MARK: BottomView's childs:
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubviews(views: [likesView,
                                       commentsView,
                                       sharesView,
                                       viewsView])
        
        bottomView.subviews.forEach { view in
            view.anchorSize(withConstant: NewsfeedCellConstants.bottomViewViewSize.width,
                          heightConstant: NewsfeedCellConstants.bottomViewViewSize.height)
            view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
            
        }
        
        // likesView constraints
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        
        // commentsView constraint
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        
        // sharesView constraints
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        
        // viewsView constraints
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        
        
    }

    // MARK: Constraints:

    private func overlayThirdLayer() {
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
    }
    
    // MARK: - Fourth layer
    
    // MARK: BottomView's View's childs:
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    // MARK: Constraints:
    
    private func overlayFourthLayer() {
        likesView.addSubviews(views: [likeImageView, likesLabel])
        commentsView.addSubviews(views: [commentsImageView, commentsLabel])
        sharesView.addSubviews(views: [sharesImageView, sharesLabel])
        viewsView.addSubviews(views: [viewsImageView, viewsLabel])
        
        let imageViews = [likeImageView, commentsImageView, sharesImageView, viewsImageView]
        let labels = [likesLabel, commentsLabel, sharesLabel, viewsLabel]
        
        imageViews.forEach { imageView in
            imageView.anchorSize(withConstant: NewsfeedCellConstants.bottomViewViewsIconSize.width,
                                 heightConstant: NewsfeedCellConstants.bottomViewViewsIconSize.height)
            guard let parentView = imageView.superview else { return }
            imageView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 6).isActive = true
            imageView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        }
        
        for (i,label) in labels.enumerated() {
            guard
                let parentView = label.superview,
                labels.count == imageViews.count
            else { return }
            label.leadingAnchor.constraint(equalTo: imageViews[i].trailingAnchor, constant: 5).isActive = true
            label.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -5).isActive = true
        }
        
    }

}
