//
//  FeedViewController.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService: Networking = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let params = ["filters": "post,photo"]
        networkService.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json)")
            
        }
        view.backgroundColor = .blue
    }
    

}
