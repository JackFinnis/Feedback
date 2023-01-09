//
//  CompaniesVM.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import Foundation

@MainActor
class CompaniesVM: ObservableObject {
    @Published var companies = [Company]()
    
    func fetchCompanies() async {
        companies = [
            Company(id: "2", name: "McDonalds", photoUrl: URL(string: "https://pbs.twimg.com/profile_images/1579916871654117376/Dxd2l1sN_400x400.png")!)
        ]
    }
}
