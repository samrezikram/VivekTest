//
//  NYTimeApkiKeyService.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/2021.
//

// Get Api Key using stroed property, Shell script is alos added in case we want to secure API Key.
import Foundation
public var apiKey: String {
  get {
    // 1
    guard let filePath = Bundle.main.path(forResource: "NYTimeApiKey", ofType: "plist") else {
      fatalError("Couldn't find file 'NYTimeApiKey.plist'.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'NYTimeApiKey.plist'.")
    }
    // 3
    if (value.starts(with: "_")) {
      fatalError("Register for a NY Times developer account and get an API key at https://developer.nytimes.com/docs/most-popular-product/1/overview.")
    }
    return value
  }
}
