//
//  FeedViewController.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getFeed()
        view.backgroundColor = .blue
    }
    

}
