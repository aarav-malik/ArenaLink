import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack{
        HStack{
            Circle()
                .foregroundColor(.gray)
                .frame(width: 150, height: 150)
                .overlay(
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(40)
                    )
                .padding(50)
            Spacer()
        }
        Spacer()
    }
        Spacer()
    }
}
