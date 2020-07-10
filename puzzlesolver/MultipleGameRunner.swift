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

    var combinatoryDictionary: [Int: Int] = [:]
    func combinatoryStrategy(for game: Game) -> Int {
        let isNewGame = game.playedGuesses.count == 0
        if isNewGame { self.readjustCombinatoryDictionary(givenGame: game) }

        combinatoryDictionary[game.playedGuesses.count] =
            combinatoryDictionary[game.playedGuesses.count] ?? 0

        return combinatoryDictionary[game.playedGuesses.count]!
    }

    private func readjustCombinatoryDictionary(givenGame game: Game, atIndex index: Int = 0) {
        let lastValue = self.combinatoryDictionary[index] ?? -1
        self.combinatoryDictionary[index] = (lastValue + 1) % game.numberOfPositions

        let wrappedAround = lastValue == game.numberOfPositions-1
        if wrappedAround { self.readjustCombinatoryDictionary(givenGame: game, atIndex: index+1) }
    }

    func run() {
        for _ in 0..<numberOfGames {
            let game = Game(
                strategy: randomStrategy,
                guessesMaximumLength: self.currentMin?.count ?? 100
            )
            switch game.playGame() {
            case .success(let result):
                if result.count < currentMin?.count ?? Int.max {
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
