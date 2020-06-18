//
//  FooterView.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 18.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(views: [myLabel, loader])
        
        // myLabel constaints
        myLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        // loader constraints
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
        
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
