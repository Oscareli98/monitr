//
//  APINYTResults.swift
//  TVFeed
//
//  Created by Oscar Newman on 12/12/15.
//  Copyright © 2015 Oscar Newman. All rights reserved.
//

import Foundation
import SwiftyJSON

class APINYTResults {
    
    var status: String!
    var numResults: Int!
    var results: [Article]!
    
    
    init(fromJson json: JSON!) {
        if json == nil {
            return
        }
        
        status = json["status"].stringValue
        numResults = json["num_results"].intValue
        
        results = []
        var resultsArray = json["results"].arrayValue
        resultsArray = resultsArray.filter({$0["multimedia"].arrayValue.count > 0})

        for result in resultsArray {
            let article = Article(fromNYTJson: result)            
            results.append(article)
        }
        
        
    }
    
}