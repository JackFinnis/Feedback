//
//  ViewModel.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var showGetFlow = false
    @Published var showSendFlow = false
    
    @Published var url: URL?
    @Published var foundUrl = false
    
    func handleUrl(_ url: URL) {
        self.url = url
        foundUrl = true
    }
}
