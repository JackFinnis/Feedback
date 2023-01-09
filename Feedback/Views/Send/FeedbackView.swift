//
//  FeedbackView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject var sendVM: SendVM
    @Binding var showSendFlow: Bool
    
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextEditor(text: $sendVM.text)
                    .focused($focused)
                    .overlay(alignment: .leading) {
                        if sendVM.text.isEmpty {
                            Text("Enter your feedback")
                                .padding(.leading, 4)
                                .foregroundColor(Color(UIColor.placeholderText))
                                .allowsHitTesting(false)
                        }
                    }
            }
            
            if !focused {
                NavigationLink {
                    SuccessView(showModal: $showSendFlow, type: .send)
                } label: {
                    Text("Submit")
                        .bottomButton()
                }
                .disabled(sendVM.text.trimmed.isEmpty)
            }
        }
        .navigationTitle("Back")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Enter Feedback")
                    .font(.headline)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button("Clear") {
                        sendVM.text = ""
                    }
                    .disabled(sendVM.text.isEmpty)
                    Spacer()
                    Button("Done") {
                        focused = false
                    }
                    .font(.headline)
                }
            }
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedbackView(sendVM: SendVM(), showSendFlow: .constant(true))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
