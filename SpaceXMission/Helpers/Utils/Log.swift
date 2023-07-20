//
//  Log.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation


final class Log {
#if DEBUG
    private static var isLogEnabled: Bool = true
#else
    private static let isLogEnabled: Bool = false
#endif
   
    static func d( callingFunctionName: String = #function, callingClassName: String = #file, line: Int = #line, _ message: String = "", file: Any? = nil) {
            
        if self.isLogEnabled {
            if let file = file {
                print("info => \((callingClassName as NSString).lastPathComponent) - \(callingFunctionName)" + "on line \(line)"  + " => " + message + "\(file)")
            } else {
                print("info => \((callingClassName as NSString).lastPathComponent) - \(callingFunctionName)" + "on line \(line)" + " => " + message)
            }
        }
    }
}
