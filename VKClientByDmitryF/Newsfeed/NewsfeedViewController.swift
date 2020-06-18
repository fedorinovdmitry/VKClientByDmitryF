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

    // MARK: - Public Properties
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    
    // MARK: - Private Properties
    
    private var feedViewModel = NewsfeedViewModel.init(cells: [], footerTitle: nil)
    
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
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
        setupTable()
        setupTopBars()
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    private func setupTable() {
        let topInset: CGFloat = 8
        table.contentInset.top = topInset
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        table.addSubview(refreshControl)
        table.tableFooterView = footerView
    }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true //скрывает при пролистывание вниз
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
    // MARK: - Public methods
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            footerView.setTitle(feedViewModel.footerTitle)
            table.reloadData()
            refreshControl.endRefreshing()
        case .displayUser(let userViewModel):
            self.titleView.set(userViewModel: userViewModel)
        case .displayFooterLoader:
            footerView.showLoader()
            
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    //позволяет отложить рассчет высоты сложных ячеек с загрузки до прокрутки
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    // отслеживаем пролистывания ленты до конца
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
}

// MARK: - NewsfeedCodeCellDelegate

extension NewsfeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsfeedCodeCell) {
        
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        
        interactor?.makeRequest(request: .revealPost(id: cellViewModel.postId))
    }
    
}
