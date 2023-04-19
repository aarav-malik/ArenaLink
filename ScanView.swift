import SwiftUI
import AVFoundation

struct ScanView: View {
    @StateObject var scannerController = ScannerController()
    @Binding var scanned: Bool
    @State private var showManualEntry = false
    
    var body: some View {
        ZStack {
            if showManualEntry {
                ManualEntryView(scanned: $scanned)
            } else {
                GeometryReader { geometry in
                    ZStack {
                        if let previewLayer = scannerController.preview {
                            PreviewView(layer: previewLayer)
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Text("Cannot start camera")
                        }
                    }
                    .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
                }
                .onAppear {
                    scannerController.startSession()
                }
                .onDisappear {
                    scannerController.stopSession()
                }
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            showManualEntry = true
                        }, label: {
                            Text("Enter Details Manually")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        .padding()
                    }
                )
            }
        }
    }

}


class ScannerController: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    private let captureSession = AVCaptureSession()
    private let metadataOutput = AVCaptureMetadataOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        super.init()
        configureSession()
    }
    
    func startSession() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopSession() {
        captureSession.stopRunning()
    }
    
    private func configureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Failed to get the camera input")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Failed to add the camera input to the session")
            return
        }
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Failed to add the metadata output to the session")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
    }
    
    var preview: AVCaptureVideoPreviewLayer? {
        guard let layer = previewLayer else {
            print("Preview layer is nil")
            return nil
        }
        return layer
    }
    
    // Implement delegate methods here
    
}

struct PreviewView: UIViewRepresentable {
    let layer: AVCaptureVideoPreviewLayer
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        layer.frame = view.layer.bounds
        view.layer.addSublayer(layer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        layer.frame = uiView.layer.bounds
    }
}

struct ManualEntryView: View{
    @State private var seat = ""
    @State private var code = ""
    @State private var selectedOption = "Yes"
    @State private var stadium = ""
    @State private var date = Date()
    @Binding var scanned: Bool


    var body: some View {
        Form {
            Section(header: Text("Enter Information")) {
                TextField("Seat Number (Type 3A)", text: $seat)
                TextField("Stadium (Type Wembley)", text: $stadium)
                DatePicker("Date & Time", selection: $date, in: ...Date())
                SecureField("Verification Code(Type 12wde21)", text: $code)
                Text("Is a person without a phone sitting on either sides of you? (family members)")
                Picker("Is a person without a phone sitting on either sides of you? (family members)", selection: $selectedOption) {
                    Text("Yes (Go to No)").tag("Yes")
                    Text("No").tag("No")
                }
                .pickerStyle(WheelPickerStyle())
            }

            Button(action:{
                scanned=true
            }){
                HStack{
                    Text("Submit")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            
            
        }
    }
}

