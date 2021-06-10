//
//  ViewController.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/2021.
//

import UIKit
class ViewController: UIViewController {
    
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

        // Adds Optional Refreshing Control
//        self.addRefreshControl(to: NYTNewsTableView)

        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.nytNewsViewModel =  NYTViewModel()
        self.nytNewsViewModel.bindnytNewsViewModelToController = {
            self.updateDataSource()
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
