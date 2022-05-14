//
//  Array.Hashable.swift
//  Tic-Tac-Toe
//
//  Created by Scott Lydon on 5/13/22.
//

import Foundation

extension Array where Element: Hashable {
    var set: Set<Element> {
        Set(self)
    }
}
