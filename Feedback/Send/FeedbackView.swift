//
//  FeedbackView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct FeedbackView: View {
    @State var text = ""
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextEditor(text: $text)
                    .focused($focused)
                    .overlay(alignment: .leading) {
                        if text.isEmpty {
                            Text("Enter your feedback")
                                .padding(.leading, 4)
                                .foregroundColor(Color(UIColor.placeholderText))
                                .allowsHitTesting(false)
                        }
                    }
            }
            
            if !focused {
                NavigationLink {
                    SuccessView(type: .send)
                } label: {
                    Text("Submit")
                        .bottomButton()
                }
                .disabled(text.trimmed.isEmpty)
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
                        text = ""
                    }
                    .disabled(text.isEmpty)
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
            FeedbackView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
