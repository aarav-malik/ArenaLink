import SwiftUI

struct HomeView: View {
    @State private var opacity = 0.0
    @State private var isPressed = false
    @State private var isExpanded = false
    
    var body: some View {
        GeometryReader { geo in
            
            ScrollView {
                
                VStack {
                        Text("Welcome")
                            .font(.system(size: 36, weight: .regular, design: .default))
                            .foregroundColor(Color.blue.opacity(0.5))
                            .padding(.leading)
                        NavigationLink(destination: ProfileView()) {
                            Text("Apple")
                                .font(.system(size: 36, weight: .bold, design: .default))
                                .foregroundColor(Color.blue.opacity(1))
                                .opacity(opacity)
                                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
                        }
                        Spacer()
                    
                    ForEach(matches, id: \.self) { match in
                        Button(action: {
                            self.isPressed.toggle()
                        }) {
                            HStack {
                                VStack{
                                    Image(match.homeTeam.replacingOccurrences(of: " ", with: ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    Text(match.homeTeam)
                                        .font(.caption)
                                        .padding(.top, 4)
                                }
                                Spacer()
                                Text("VS")
                                    .font(.subheadline)
                                    .padding(.top,4)
                                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                
                                
                                Spacer()
                                VStack{
                                    Image(match.awayTeam.replacingOccurrences(of: " ", with: ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text(match.awayTeam)
                                        .font(.caption)
                                        .padding(.top, 4)
                                }
                            }                            
                            .frame(width:  geo.size.width * 0.8, height: geo.size.height * 0.1)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .onAppear {
                    withAnimation {
                        opacity = 1.0
                    }
                }
                VStack{
                    HStack{
                        Text("Today")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                            .padding(.leading)
                        Spacer()
                        
                    }
                    Headline(headline:"End plastic waste: MLS unveils One Planet Kit made of recycled materials", image:Image("headline1"), Time:"Tuesday, Apr 18, 2023, 10:55 PM")
                        .padding(.bottom,-10)
                    Headline(headline:"Why are some of MLS's most prominent clubs struggling?", image:Image("headline2"), Time:"Tuesday, Apr 18, 2023, 05:34 AM")
                        .padding(.bottom,-10)
                    Headline(headline:"LAFC's Carlos Vela hits another record with top-corner golazo", image:Image("headline3"), Time:"Monday, Apr 17, 2023, 05:52 AM")
                        .padding(.bottom,-10)


                }
            }       
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct Headline : View{
    let headline: String
    let image : Image
    let Time : String
    var body: some View{
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(height: 130)
                    .padding()
                
                HStack{
                    VStack{
                        Text(headline)
                            .font(.headline)
                            .padding(20)
                            .padding()
                            .foregroundColor(Color.blue.opacity(0.7))
                        Text(Time)
                            .font(.caption2)
                            .foregroundColor(Color.black.opacity(0.5))
                            .padding(.top, -40)
                            .padding(.leading)
                    }
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 100)
                        .frame(maxWidth: 100)

                        .padding(.trailing, 40)
                }

            }


    
        }
    }
}
