//
//  Int+Extension.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import Foundation

extension Int {
    func startWith(number: Int) -> Bool {
        do {
            let text = String(self)
            
            let first = text.character(at: 0)
            guard let firstNumber = first?.wholeNumberValue else {
                return false
            }
            return firstNumber == number
        } catch {
            return false
        }
    }
}
