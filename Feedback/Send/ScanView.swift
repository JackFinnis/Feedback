//
//  ScanView.swift
//  Camera
//
//  Created by Jack Finnis on 16/09/2022.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    @State var animate = true
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("", isActive: $vm.foundUrl) {
                    CompanyLogoView()
                }
                .hidden()
                
                QRScanner { url in
                    vm.handleUrl(url)
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.5))
                    Rectangle()
                        .cornerRadius(20)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(30)
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.accentColor.opacity(animate ? 1 : 0), lineWidth: 4)
                        .animation(.easeInOut(duration: 1), value: animate)
                        .padding(30)
                    Rectangle()
                        .padding(-10)
                        .rotationEffect(.degrees(45))
                        .blendMode(.destinationOut)
                }
                .aspectRatio(1, contentMode: .fit)
                .compositingGroup()
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Back")
            .onAppear(perform: pulse)
            .onChange(of: animate) { _ in pulse() }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Scan QR Code")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    func pulse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animate.toggle()
        }
    }
}

struct QRScanner: UIViewControllerRepresentable {
    let foundUrl: (URL) -> Void
    
    func makeUIViewController(context: Context) -> QRScannerVC {
        let vc = QRScannerVC()
        vc.foundUrl = foundUrl
        return vc
    }
    
    func updateUIViewController(_ vc: QRScannerVC, context: Context) {}
}

class QRScannerVC: UIViewController {
    var session: AVCaptureSession?
    var foundUrl: ((URL) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device)
        else { return }
        
        session = AVCaptureSession()
        session?.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        session?.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]
        
        let preview = AVCaptureVideoPreviewLayer(session: session!)
        preview.frame = view.layer.bounds
        view.layer.addSublayer(preview)
        
        session!.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        session?.startRunning()
    }
}

extension QRScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        session?.stopRunning()
        
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let string = object.stringValue,
              let url = URL(string: string)
        else {
            session?.startRunning()
            return
        }
        
        Haptics.tap()
        foundUrl?(url)
    }
}
