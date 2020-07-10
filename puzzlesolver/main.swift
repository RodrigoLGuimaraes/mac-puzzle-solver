//
//  main.swift
//  puzzlesolver
//
//  Created by Rodrigo Guimaraes on 10/07/20.
//  Copyright © 2020 RodrigoLG. All rights reserved.
//

import Foundation

let initial = Date()
print("Started at \(initial)")
MultipleGameRunner().run()
let distance = initial.distance(to: Date())
print("Finished after \(distance) seconds")
