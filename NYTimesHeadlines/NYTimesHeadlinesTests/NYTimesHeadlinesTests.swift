//
//  NYTimesHeadlinesTests.swift
//  NYTimesHeadlinesTests
//
//  Created by Samrez Ikram on 03/05/2021.
//

import XCTest
@testable import  NYTimesHeadlines
class NYTimesHeadlinesTests: XCTestCase {
    
    var sut: URLSession!
    var networkMonitor = InternetConnectionManager.sharedInstance

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }
   

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }

    // Asynchronous test: success fast, failure slow
    func testApiCallCompletes() throws {
        try XCTSkipUnless(
            true)
      // given
        let sourcesURL = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=\(apiKey)")!
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: sourcesURL) { responseData, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        let jsonDecoder = JSONDecoder()
        let mostPopularNews = try! jsonDecoder.decode(NYTMostpopularNews.self, from: responseData!)
        
        mostPopularNews.results.forEach { (result:Result) in
            
            if let title = result.title, let byLine =  result.byline, let publishedData = result.publishedDate {
                if ( title.isEmpty || byLine.isEmpty || publishedData.isEmpty){
                    XCTAssertThrowsError("value or null")
                }
            }
        }
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 10)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
}
