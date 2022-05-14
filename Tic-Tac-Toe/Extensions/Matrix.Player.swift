//
//  Matrix.Player.swift
//  Tic-Tac-Toe
//
//  Created by Scott Lydon on 5/13/22.
//

import Foundation

extension Array where Element == [Player?] {

    static func emptyTickTackToeBoard(rows: Int) -> Self {
        Array(repeating: [Player?](repeating: nil, count: rows), count: rows)
    }

    var winner: Player? {
        rowWinner ??
        columnWinner ??
        topLeftToBottomRght.winner ??
        bottomLeftToTopRight.winner
    }

    var noNils: Bool {
        allSatisfy(\.noNils)
    }

    /// Assumes self is a square
    var rowWinner: Player? {
        compactMap(\.winner).first ?? nil
    }

    /// Assumes self is a square
    var columnWinner: Player? {
        indices.compactMap { column($0).winner }.first
    }

    /// assumes self is a square
    func column(_ index: Int) -> [Player?] {
        map { $0[index] }
    }

    /// Assumes self is a square
    var topLeftToBottomRght: [Player?] {
        indices.map { self[$0][$0] }
    }

    /// Assumes self is a square
    var bottomLeftToTopRight: [Player?] {
        indices.map { self[count - 1 - $0][$0]}
    }
}
