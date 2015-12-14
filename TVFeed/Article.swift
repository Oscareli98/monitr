//
//  File.swift
//  TVFeed
//
//  Created by Oscar Newman on 12/12/15.
//  Copyright © 2015 Oscar Newman. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {
    
    var title: String!
    var description: String!
    var url: String!
    var author: String!
    var datePosted: NSDate!
    var imageURL: NSURL!
    
    init(fromNYTJson json: JSON!) {
        if json == nil {
            return
        }
        
        title = json["title"].stringValue
        description = json["abstract"].stringValue
        url = json["url"].stringValue
        author = json["byline"].stringValue

        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: -5 * 60 * 60)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let stringDate = json["created_date"].stringValue
        let substring = stringDate.substringToIndex(stringDate.endIndex.advancedBy(-5))
        datePosted = dateFormatter.dateFromString(substring)
        
        let mediaArray = json["multimedia"].arrayValue.filter({$0["type"].stringValue == "image" && $0["format"].stringValue == "superJumbo"})
        let imageURLString = mediaArray.first?["url"].stringValue
        if let imgURL = imageURLString {
            imageURL = NSURL(string: imgURL)!
        }
    }
    
    
}