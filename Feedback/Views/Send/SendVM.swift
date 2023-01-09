//
//  SendVM.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import Foundation

@MainActor
class SendVM: ObservableObject {
    @Published var companyID: String?
    @Published var foundCompanyID = false
    
    @Published var company: Company?
    @Published var loading = false
    
    @Published var text = ""
    
    func fetchCompany(companyID: String) async {
        loading = true
        company = Company(id: "2", name: "McDonalds", photoUrl: URL(string: "https://pbs.twimg.com/profile_images/1579916871654117376/Dxd2l1sN_400x400.png"))
        loading = false
    }
    
    func handleUrl(_ url: URL) {
        companyID = "2"
        foundCompanyID = true
    }
}
