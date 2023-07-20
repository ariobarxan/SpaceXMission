//
//  StringExtension.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

extension String {
    
    func localized(bundle:Bundle = .main, tableName:String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}
