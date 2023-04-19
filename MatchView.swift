import SwiftUI
import AVKit



struct MatchView: View {
    @State private var opacity = 0.0
    @State private var isPressed = false
    @State private var isLinkActive = false
    @Binding var scanned: Bool

    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    VStack{
                        ForEach(gamesToday, id: \.self) { game in
                            Button(action: {
                                self.isPressed.toggle()
                            }) {
                                HStack {
                                    VStack{
                                        Image(game.homeTeam.replacingOccurrences(of: " ", with: ""))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        Text(game.homeTeam)
                                            .font(.caption)
                                            .padding(.top, 4)
                                    }
                                    Spacer()
                                    Text("VS")
                                        .font(.subheadline)
                                        .padding(.top,4)
                                    
                                    Spacer()
                                    VStack{
                                        Image(game.awayTeam.replacingOccurrences(of: " ", with: ""))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(game.awayTeam)
                                            .font(.caption)
                                            .padding(.top, 4)
                                    }
                                }
                                
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 10)
                            }
                            .frame(width:  geo.size.width * 0.8, height: geo.size.height * 0.2)
                            .buttonStyle(PlainButtonStyle())
                        }
                        HStack{
                                NavigationLink(destination: TifoView(), isActive: $isLinkActive) {
                                    EmptyView()
                                }
                                Button(action:{
                                    self.isLinkActive = true
                                }) {
                                    Text("Tifo")
                                        .padding(60)
                                }
                                .foregroundColor(Color.black)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .shadow(radius: 10)
                                Spacer()
                            }
                        .padding()
                        Spacer()
                    }
                    .padding(.top)
                    .onAppear {
                        withAnimation {
                            opacity = 1.0
                        }
                    }
                    Button(action: {scanned=false}){
                        Text("End Match")
                    }
                    .padding(.bottom,10)
                    .foregroundColor(Color.red)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                

            }
        }
    }
}
