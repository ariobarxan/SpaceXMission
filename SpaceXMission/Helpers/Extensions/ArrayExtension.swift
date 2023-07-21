//
//  ArrayExtension.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func appendIfNotDuplicated(_ item: Element) {
        if !self.contains(item) {
            self.append(item)
        }
    }
    
    
    mutating func appendIfNotDuplicated<S>(contentsOf newElements: S) where Element == S.Element, S : Sequence {
        for newElement in newElements {
            appendIfNotDuplicated(newElement)
        }
    }
  
}
