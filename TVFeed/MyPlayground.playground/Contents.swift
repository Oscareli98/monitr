//: Playground - noun: a place where people can play

import Cocoa

var str = "2015-12-12T20:34:40-5:00"

str = str.substringToIndex(str.endIndex.advancedBy(-5))

let dateFormatter = NSDateFormatter()
dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: -5 * 60 * 60)
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
let date = dateFormatter.dateFromString(str)

date
