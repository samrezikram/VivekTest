
//
//  NYTViewModel.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/2021.
//


import Foundation
import ProgressHUD
class NYTViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var mostPopularNews : NYTMostpopularNews! {
        didSet {
            self.bindnytNewsViewModelToController()
        }
    }
    
    var bindnytNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetNYTNewsResults()
    }
    
    func callFuncToGetNYTNewsResults() {
        ProgressHUD.show()
        
        self.apiService.apiToGetMostPopualarNYTNews { (mostPopularNews) in
            self.mostPopularNews = mostPopularNews
            ProgressHUD.dismiss()
        }
    }
}

