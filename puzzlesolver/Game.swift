//
//  Game.swift
//  puzzlesolver
//
//  Created by Rodrigo Guimaraes on 10/07/20.
//  Copyright © 2020 RodrigoLG. All rights reserved.
//

import Foundation

enum GameError: Error {
    case lose
}

class Game {
    let numberOfPositions: Int
    let guessesMaximumLength: Int
    var possibleDroids = [Int]()
    var playedGuesses = [Int]()
    var strategy: (Game) -> Int

    init(strategy: @escaping (Game) -> Int,
        numberOfPositions: Int = 5,
        guessesMaximumLength: Int = 50) {
        self.strategy = strategy
        self.numberOfPositions = numberOfPositions
        self.guessesMaximumLength = guessesMaximumLength
        for i in 0..<numberOfPositions {
            possibleDroids.append(i)
        }
    }

    func playGame() -> Result<[Int], Error> {
        var iterations = 0
        while !possibleDroids.isEmpty && iterations < guessesMaximumLength {
            iterations += 1

            let newPlayPosition = self.strategy(self)
            self.playedGuesses.append(newPlayPosition)

            possibleDroids = possibleDroids
                .flatMap { self.droidPlay($0, forGameWith: self.numberOfPositions) }
                .removeDuplicates()
                .filter { $0 != newPlayPosition }
        }

        if possibleDroids.isEmpty { return .success(self.playedGuesses) }
        else { return .failure(GameError.lose) }
    }

    func droidPlay(
        _ index: Int,
        forGameWith numberOfPositions: Int
    ) -> [Int] {
        var newPossiblePositions = [Int]()

        let isNotOnTheVeryLeft = index > 0
        let isNotOnTheVeryRight = index < numberOfPositions - 1

        if isNotOnTheVeryLeft { newPossiblePositions.append(index - 1) }
        if isNotOnTheVeryRight { newPossiblePositions.append(index + 1) }

        return newPossiblePositions
    }
}
