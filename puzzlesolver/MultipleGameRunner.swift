//
//  MultipleGameRunner.swift
//  puzzlesolver
//
//  Created by Rodrigo Guimaraes on 10/07/20.
//  Copyright © 2020 RodrigoLG. All rights reserved.
//

import Foundation

class MultipleGameRunner {

    private let numberOfGames: Int
    private var currentMin: [Int]?

    init(numberOfGames: Int = 100000) {
        self.numberOfGames = numberOfGames
    }

    // MARK: - Strategies
    func randomStrategy(for game: Game) -> Int {
        return Int.random(in: 0..<game.numberOfPositions)
    }

    func run() {
        for _ in 0..<numberOfGames {
            switch Game(strategy: randomStrategy).playGame() {
            case .success(let result):
                if result.count < currentMin?.count ?? Int.max {
                    print("We already have a winner \(result)")
                    currentMin = result
                }
            default:
                ()
            }
        }

        if let result = currentMin {
            print("Yay \(result)")
        } else {
            print("Shit!")
        }
    }
}
