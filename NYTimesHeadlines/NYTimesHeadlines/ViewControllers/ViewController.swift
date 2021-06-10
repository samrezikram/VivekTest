//
//  ViewController.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/2021.
//

import UIKit
class ViewController: UIViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    
        self.dataSource.filteredTableData.removeAll(keepingCapacity: false)
        
        guard let searchText = searchController.searchBar.text else {
              return
        }

        let array = self.nytNewsViewModel.mostPopularNews.results.filter {
            return $0.title?.lowercased().range(of: searchText.lowercased()) != nil
        }

        self.dataSource.filteredTableData = array

        self.NYTNewsTableView.reloadData()
    }
    
    
    @IBOutlet weak var NYTNewsTableView: UITableView!
    
    private var nytNewsViewModel : NYTViewModel!
    
    private var dataSource : NYTNewsTableViewDataSource<NYTNewsTableViewCell,Result>!
    

    //------------------------------------------------------
    
    // Adds Optional Refreshing Control
    /*lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
        return refreshControl
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NYTNewsTableViewCell", bundle: nil)
        NYTNewsTableView.register(nib, forCellReuseIdentifier: "NYTNewsTableViewCell")
        self.NYTNewsTableView.rowHeight = 120

        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.nytNewsViewModel =  NYTViewModel()
        self.nytNewsViewModel.bindnytNewsViewModelToController = {
            DispatchQueue.main.async {
                self.updateDataSource()
                self.updateSearch()
            }
        }
    }
    
    func updateDataSource(){
        self.dataSource = NYTNewsTableViewDataSource(cellIdentifier: "NYTNewsTableViewCell", items: self.nytNewsViewModel.mostPopularNews.results, configureCell: { (cell, nytNewsResult) in
            cell.newsTitleLabel.text = nytNewsResult.title
            cell.bylineLabel.text = nytNewsResult.byline
            cell.pulbisheddate.text = nytNewsResult.publishedDate
        })
        
        
        
        DispatchQueue.main.async {
            self.NYTNewsTableView.dataSource = self.dataSource
            self.NYTNewsTableView.reloadData()
//            self.refreshControl.endRefreshing()
        }
    }
    
    func updateSearch () {
        self.dataSource.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()

            DispatchQueue.main.async {
                self.NYTNewsTableView.tableHeaderView = controller.searchBar
                controller.hidesNavigationBarDuringPresentation = true;
                controller.searchBar.searchBarStyle = UISearchBar.Style.minimal;

            }
            return controller
            })()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        callToViewModelForUIUpdate()
    }
}

// Adds Optional Refreshing Control
/*extension ViewController {
    func addRefreshControl(to tableView: UITableView) {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }

        tableView.indicatorStyle = .black
    }
}*/
