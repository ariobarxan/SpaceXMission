//
//  Functions.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

func mainThread(function: @escaping () -> Void) {
    DispatchQueue.main.async(execute: function)
}
