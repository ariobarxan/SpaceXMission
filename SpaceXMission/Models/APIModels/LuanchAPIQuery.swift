//
//  LuanchAPIQuery.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

struct LaunchAPIQuery {
    var upcoming: Bool = false
    var options: Options
    
    var dict: [String: Any] {
        get {
            let temp: [String: Any] = [
                "upcoming": upcoming,
                "options": options.dict
            ]
            return temp
        }
    }
}

struct Options {
    var limit: Int = 50
    var page: Int
    var sort: Sort
    
    var dict: [String: Any] {
        get {
            let temp: [String: Any] = [
                "limit": 50,
                "page": 1,
                "sort": sort.dict
            ]
            return temp
        }
    }
}

struct Sort {
    var key: String = "flight_number"
    var value: String = "desc"
    
    var dict: [String : Any] {
        get {
            let temp = [
                key : value
            ]
            return temp as [String : Any]
        }
    }
}

