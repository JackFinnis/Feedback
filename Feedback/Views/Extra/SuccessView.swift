//
//  SuccessView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct SuccessView: View {
    @Binding var showModal: Bool
    
    let type: SuccessType
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            VStack {
                Image(systemName: "checkmark.seal")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                Text(type.title)
                    .font(.headerTitle)
            }
            Text(type.message)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
            Spacer()
            
            Button {
                showModal = false
            } label: {
                Text(type.action)
                    .bottomButton()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(showModal: .constant(true), type: .get)
    }
}

enum SuccessType {
    case get, send
    
    var title: String {
        switch self {
        case .get:
            return "Company Started"
        case .send:
            return "Feedback Submitted"
        }
    }
    
    var message: String {
        switch self {
        case .get:
            return ""
        case .send:
            return "Thanks for your feedback! We will get back to you as soon as possible."
        }
    }
    
    var action: String {
        switch self {
        case .get:
            return "View"
        case .send:
            return "Done"
        }
    }
}
