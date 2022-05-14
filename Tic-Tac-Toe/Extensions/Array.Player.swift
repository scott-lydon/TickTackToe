//
//  Array.Player.swift
//  Tic-Tac-Toe
//
//  Created by Scott Lydon on 5/13/22.
//

import Foundation

extension Array where Element == Player? {
    var winner: Player? {
        if allSatisfy({ $0?.marker == .o }) || allSatisfy({ $0?.marker == .x}) {
            return first ?? nil
        }
        return nil
    }

    var noNils: Bool {
        allSatisfy { $0 != nil }
    }
}
