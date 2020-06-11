//
//  NewsfeedViewController.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 10.06.2020.
//  Copyright (c) 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    // MARK: - Custom types
    
    // MARK: - Constants
    
    // MARK: - Init
    
    // MARK: - LifeStyle ViewController
    
    // MARK: - IBAction
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    // MARK: - Navigation

    // MARK: - Public Properties
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    
    // MARK: - Private Properties
    
    private var feedViewModel = FeedViewModel.init(cells: [])
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsfeedInteractor()
        let presenter             = NewsfeedPresenter()
        let router                = NewsfeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        
        interactor?.makeRequest(request: .getNewsFeed)
        
    }
    
    // MARK: - Public methods
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()

        }
    }
    
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 223
    }
}
