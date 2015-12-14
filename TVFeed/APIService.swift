//
//  APIService.swift
//  TVFeed
//
//  Created by Oscar Newman on 12/12/15.
//  Copyright © 2015 Oscar Newman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    
    static let sharedInstance = APIService()
    
    func get(endpoint: APIEndpoint, success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        Alamofire.request(.GET, endpoint.rawValue)
                 .validate()
                 .response { request, response, data, error in
                    if let data = data {
                        success(data)
                    }
                 }
    }
    
    func getNYT(success: NetworkSuccessHandler, failure: NetworkFailureHandler) {
        get(.NYTimes, success: {data in
            let results = APINYTResults(fromJson: JSON(data: data as! NSData))
            success(results.results)

            }, failure: {_, data, error in
                        
        })
    }
    
}