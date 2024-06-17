import SwiftUI

struct OneAnimal: View {
    let url: String
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            Spacer()
        }
    }
}

#Preview {
    OneAnimal(url: "https://cdn2.thecatapi.com/images/9rm.png")
}


