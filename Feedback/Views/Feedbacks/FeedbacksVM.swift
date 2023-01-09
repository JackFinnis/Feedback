//
//  FeedbacksVM.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import Foundation

@MainActor
class FeedbacksVM: ObservableObject {
    @Published var feedbacks = [Feedback]()
    
    func fetchFeedbacks() async {
        feedbacks = [
            Feedback(id: "1", userID: "1", feedback: "Clean glasses", companyID: "1", response: nil),
            Feedback(id: "2", userID: "1", feedback: "Remove plastic toys", companyID: "1", response: "Great idea! We have implemented this and would love to see you back soon.")
        ]
    }
}
