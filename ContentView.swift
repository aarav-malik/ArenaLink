import SwiftUI

struct ContentView: View {
    @State private var scanned = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            if !scanned{
                ScanView(scanned: $scanned)
                    .tabItem {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
            }
            if scanned {
                MatchView(scanned: $scanned)
                    .tabItem {
                        Label("Match", systemImage: "sportscourt.fill")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
