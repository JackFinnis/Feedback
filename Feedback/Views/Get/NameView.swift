//
//  NameView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct NameView: View {
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    @FocusState var focused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    TextEditor(text: $text)
                        .focused($focused)
                        .overlay(alignment: .leading) {
                            if text.isEmpty {
                                Text("Enter company name")
                                    .padding(.leading, 4)
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .allowsHitTesting(false)
                            }
                        }
                }
                
                if !focused {
                    NavigationLink {
                        LogoView()
                    } label: {
                        Text("Next")
                            .bottomButton()
                    }
                    .disabled(text.trimmed.isEmpty)
                }
            }
            .navigationTitle("Back")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Company Name")
                        .font(.headline)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Cancel") {
                        dismiss()
                    }
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
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NameView()
        }
    }
}
