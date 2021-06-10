//
//  NetworkManager.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/21.
//  Copyright © 2018 Samrez Ikram. All rights reserved.
//
import UIKit
import Alamofire
class NetworkManager: NSObject {
    
   
    class func getMostPopularNews( withCompletionHandler: @escaping (_ response:NYTMostpopularNews?)->(Void) ) {
      
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" :"application/json; charset=utf-8"
        ]
        let sourcesURL = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=\(apiKey)")!

//        let finalURL = self.queryString(urlString: sourcesURL, params: l_requestParams!)
        
        AF.request( sourcesURL,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON { (responseData) in
                            
                            if let data = responseData.data {
                                
                                let jsonDecoder = JSONDecoder()
                                let mostPopularNews = try! jsonDecoder.decode(NYTMostpopularNews.self, from: data)
                            
                                withCompletionHandler(mostPopularNews)
                            } else {
                                withCompletionHandler(nil)
                            }
            }
    }
    
    
    class func queryString(urlString:String, params:[String: Any]) -> String {
        
        let queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value as? String) })
        
        var urlComps = URLComponents(string: urlString)
        urlComps?.queryItems = queryItems
        
        return urlComps?.url?.absoluteString ?? ""
    }
    
    
   
    
}
