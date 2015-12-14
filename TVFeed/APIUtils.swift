//
//  APIUtils.swift
//  TVFeed
//
//  Created by Oscar Newman on 12/12/15.
//  Copyright © 2015 Oscar Newman. All rights reserved.
//

import Foundation

enum APIEndpoint: String {
    
    case NYTimes = "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=96f6b055b2ad2b21cf7c7d5ac80eaea7:10:12677700"

}

public typealias NetworkSuccessHandler = (AnyObject?) -> Void
public typealias NetworkFailureHandler = (NSHTTPURLResponse?, AnyObject?, NSError) -> Void

