//
//  LogoView.swift
//  Feedback
//
//  Created by Jack Finnis on 07/01/2023.
//

import SwiftUI

struct LogoView: View {
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType?
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Group {
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 50))
                        .foregroundColor(Color(.systemFill))
                }
            }
            
            Menu((uiImage == nil ? "Add" : "Change") + " Logo") {
                Button {
                    sourceType = .photoLibrary
                } label: {
                    Label("Photo Library", systemImage: "photo.on.rectangle")
                }
                Button {
                    sourceType = .camera
                } label: {
                    Label("Take Photo", systemImage: "camera")
                }
                if uiImage != nil {
                    Button(role: .destructive) {
                        uiImage = nil
                    } label: {
                        Label("Remove Photo", systemImage: "xmark")
                    }
                }
            }
            .font(.headline)
            
            Spacer()
            
            NavigationLink {
                ConfirmLogoView()
            } label: {
                Text(uiImage == nil ? "Skip" : "Next")
                    .bottomButton()
            }
        }
        .navigationTitle("Back")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Company Logo")
                    .font(.headline)
            }
        }
        .sheet(item: $sourceType) { sourceType in
            PhotoPicker(uiImage: $uiImage, sourceType: sourceType)
                .ignoresSafeArea()
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogoView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension UIImagePickerController.SourceType: Identifiable {
    public var id: UUID { UUID() }
}
