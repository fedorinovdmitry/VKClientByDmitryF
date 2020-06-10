//
//  FeedViewController.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetcher.getFeed { (responce) in
            guard let feedResponce = responce else { return }
            
            feedResponce.items.forEach { print($0.text) }
        }
        
        view.backgroundColor = .blue
    }
    

}
