//
//  CompanyLogoView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct CompanyLogoView: View {
    @ObservedObject var sendVM: SendVM
    @Binding var showSendFlow: Bool
    
    let companyID: String
    
    var body: some View {
        VStack {
            if let company = sendVM.company {
                VStack {
                    Spacer()
                    if let photoUrl = company.photoUrl {
                        AsyncImage(url: photoUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    }
                    Text(company.name)
                        .font(.navTitle)
                    Spacer()
                    
                    NavigationLink {
                        FeedbackView(sendVM: sendVM, showSendFlow: $showSendFlow)
                    } label: {
                        Text("Next")
                            .bottomButton()
                    }
                }
            } else {
                ProgressView()
                    .task {
                        await sendVM.fetchCompany(companyID: companyID)
                    }
            }
        }
        .navigationTitle("Back")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
            }
        }
    }
}

struct CompanyLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyLogoView(sendVM: SendVM(), showSendFlow: .constant(true), companyID: "2")
    }
}
