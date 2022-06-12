//
//  String+isBlank.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

extension String {
    var isBlank: Bool {
        allSatisfy { $0.isWhitespace }
    }
}
