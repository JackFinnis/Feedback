//
//  ConfirmLogoView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct ConfirmLogoView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("mcdonalds")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(10)
            Text("McDonalds")
                .font(.navTitle)
            Spacer()
            
            NavigationLink {
//                SuccessView(type: .get)
            } label: {
                Text("Submit")
                    .bottomButton()
            }
        }
        .navigationTitle("Back")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Summary")
                    .font(.headline)
            }
        }
    }
}

struct ConfirmLogoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfirmLogoView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
