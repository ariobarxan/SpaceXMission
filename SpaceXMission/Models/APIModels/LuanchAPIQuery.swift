//
//  LuanchAPIQuery.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

struct LaunchAPIQuery {
    var query: APIQuery
    var options: Options
    
    var dict: [String: Any] {
        get {
            let temp: [String: Any] = [
                "query": query.dict,
                "options": options.dict
            ]
            return temp
        }
    }
}

struct APIQuery {
    var upcoming: Bool = false

    var dict: [String: Any] {
        get {
            return ["upcoming": upcoming]
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
                "limit": limit,
                "page": page,
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

//{
//"query": {
//       "upcoming": false
//,}
//   "options": {
//       "limit": 50,
//       "page": pageNumber,
//       "sort": {
//           "flight_number": "desc"
//}
//}
//
//}
