//
//  APIService.swift
//
//  Created by Samrez Ikram on 02/05/21.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
//

import Foundation


class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=\(apiKey)")!
    
    func apiToGetMostPopualarNYTNews(completion : @escaping (NYTMostpopularNews) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(NYTMostpopularNews.self, from: data)
            
                    completion(empData)
            }
            
        }.resume()
    }
    
}
