import SwiftUI
import SceneKit
import UIKit
import SwiftUI
import AVKit
import MobileCoreServices

class SceneDelegate: NSObject, SCNSceneRendererDelegate {
    func sceneRenderer(_ renderer: SCNSceneRenderer, didFailToRender scene: SCNScene, error: Error) {
        print("Failed to render scene: \(error)")
    }
}


struct TifoView: View {
    @State private var pressed = false
    @State private var showVideoPicker = false
    @State private var videoURL: URL?
    @State private var animateGradient = false

    var body: some View {
        VStack{
            Text("Preview")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            SceneView(scene: SCNScene(named: "10093_Wembley_stadion_V3_Iteration0.obj"), options: [.autoenablesDefaultLighting,.allowsCameraControl], delegate: SceneDelegate())
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0), // modify the x value here
                    anchor: .center,
                    perspective: 1.0

                )
                }
            
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            if let videoURL = videoURL {
                           VideoPlayer(player: AVPlayer(url: videoURL))
                               .frame(height: 300)
                               .onDisappear {
         
                                   try? FileManager.default.removeItem(at: videoURL)
                               }
                       } else {
                           Text("Suggest a Tifo")
                       }
                       
                       Button("Select Video") {
                           self.showVideoPicker = true
                       }
                       .sheet(isPresented: $showVideoPicker) {
                           ImagePickerView(sourceType: .photoLibrary, mediaTypes: [kUTTypeMovie as String]) { result in
                               guard case let .success(videoURL) = result else { return }
                               self.videoURL = videoURL
                           }
                       }

            Spacer()
            Text("A Tifo is active:")
            NavigationLink(destination: Screen(), isActive: $pressed) {
                EmptyView()
            }

            Button(action: {                                    self.pressed = true

            }, label: {
                Text("Tifo")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })

        }
    }

struct ImagePickerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Result = Swift.Result<URL, Error>
    
    let sourceType: UIImagePickerController.SourceType
    let mediaTypes: [String]
    let onResult: (Result) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.mediaTypes = mediaTypes
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onResult: onResult)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let onResult: (Result) -> Void
        
        init(onResult: @escaping (Result) -> Void) {
            self.onResult = onResult
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            guard let url = info[.mediaURL] as? URL else {
                onResult(.failure(ImagePickerError.invalidData))
                return
            }
            
            onResult(.success(url))
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
            onResult(.failure(ImagePickerError.userCancelled))
        }
    }
    
    enum ImagePickerError: Error {
        case invalidData
        case userCancelled
    }
}
struct Screen: View {
@State private var animateGradient = false    
    var body: some View {
    
  
        LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            } }
}
    

