//
//  Enum.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import Foundation

enum CustomError: Error {
    case expected(message: String)
    case unexpected(code: Int)
}
