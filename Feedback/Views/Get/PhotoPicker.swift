//
//  PhotoPicker.swift
//  Ecommunity
//
//  Created by Jack Finnis on 22/11/2021.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var uiImage: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            func completion(_ uiImage: UIImage) {
                parent.uiImage = uiImage
                parent.dismiss()
            }
            if let uiImage = info[.editedImage] as? UIImage {
                completion(uiImage)
            } else if let uiImage = info[.originalImage] as? UIImage {
                completion(uiImage)
            }
        }
    }
}
