//
//  String.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import Foundation

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
