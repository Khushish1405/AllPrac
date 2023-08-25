//
//  cricdata.swift
//  tableView
//
//  Created by Jaimin Solanki on 16/08/23.
//

import Foundation


struct CricData: Codable {
    var apikey: String
    var data: [CricScore]
}

struct CricScore: Codable{
    var id: String
    var dateTimeGMT: String
    var matchType: String
    var status: String
    var ms: String
    var t1: String
    var t2: String
    var t1s: String
    var t2s: String
    var t1img: String?
    var t2img: String?
}
