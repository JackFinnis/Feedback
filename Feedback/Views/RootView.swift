//
//  RootView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct RootView: View {
    @StateObject var feedbacksVM = FeedbacksVM()
    @StateObject var companiesVM = CompaniesVM()
    @State var showSendFlow = false
    @State var showGetFlow = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Spacer()
                VStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.largeTitle)
                    Text("Feedback")
                        .font(.navTitle)
                }
                Text("The simplest way to send & receive anonymous feedback")
                    .padding(.horizontal, 50)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    if feedbacksVM.feedbacks.isNotEmpty {
                        NavigationLink("My Suggestions") {
                            
                        }
                        .font(.headline)
                    }
                    if companiesVM.companies.isNotEmpty {
                        NavigationLink("My Companies") {
                            
                        }
                        .font(.headline)
                    }
                }
                .padding()
                
                Spacer()
                Button("Get Feedback") {
                    showGetFlow = true
                }
                .font(.headline)
                .padding()
                .sheet(isPresented: $showGetFlow) {
                    NameView()
                }
                
                Button {
                    showSendFlow = true
                } label: {
                    Text("Send Feedback")
                        .bottomButton()
                }
                .sheet(isPresented: $showSendFlow) {
                    ScanView(showSendFlow: $showSendFlow)
                }
            }
            .task {
                await feedbacksVM.fetchFeedbacks()
                await companiesVM.fetchCompanies()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
