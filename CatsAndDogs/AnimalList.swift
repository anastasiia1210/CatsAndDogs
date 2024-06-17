import SwiftUI

struct AnimalList: View {
    @State private var animals: [String] = []
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(animals, id: \.self) { animal in
                        NavigationLink(destination: OneAnimal(url: animal)){
                        
                            AsyncImage(url: URL(string: animal)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                            }
                        placeholder: {
                            ProgressView()
                        } .accessibilityIdentifier("AnimalImage_\(animal)")
                        }
                    }
                }}}
        .padding()
        .onAppear {
          var url = "https://api.thecatapi.com/v1/images/search?limit=10"
            
            
            let dogsOrCats = Bundle.main.object(forInfoDictionaryKey: "ANIMALS") as? String ?? ""
            if (dogsOrCats == "CATS") {url = "https://api.thecatapi.com/v1/images/search?limit=10"}
            if (dogsOrCats == "DOGS") {url = "https://api.thedogapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=10"}
            Task {
                if let fetchedAnimals = await getAnimals(url) {
                    animals = fetchedAnimals
                }
            }
          
        }
    }
}

#Preview {
    AnimalList()
}


