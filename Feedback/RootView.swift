//
//  RootView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct RootView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            VStack {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.largeTitle)
                Text("Feedback")
                    .font(.navTitle)
            }
            Text("The simplest way to send & receive feedback")
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
            Spacer()
            
            Button("Get Feedback") {
                vm.showGetFlow = true
            }
            .font(.headline)
            .padding()
            .sheet(isPresented: $vm.showGetFlow) {
                NameView()
            }
            
            Button {
                vm.showSendFlow = true
            } label: {
                Text("Send Feedback")
                    .bottomButton()
            }
            .sheet(isPresented: $vm.showSendFlow) {
                ScanView()
            }
        }
        .environmentObject(vm)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
