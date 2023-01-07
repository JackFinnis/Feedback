//
//  View.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

extension View {
    func horizontallyCentred() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    func bottomButton() -> some View {
        self
            .font(.headline)
            .padding()
            .horizontallyCentred()
            .foregroundColor(.white)
            .background(Color.accentColor.ignoresSafeArea())
    }
}
