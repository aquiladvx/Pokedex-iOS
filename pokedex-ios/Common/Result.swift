//
//  Result.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation

//class Result<T> {
//
//    let data: T? = nil
//    let errorCode: Int? = nil
//
//    init(data: T, errorCode: Int) {
//        self.data = data
//        self.errorCode = errorCode
//    }
//
//    class Success<T>(data: T) : Result<T>(data)
//}
enum Result<T> {
    case success(T?)
    case errorCode(Int?)
    
}
