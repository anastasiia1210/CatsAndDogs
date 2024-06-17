import Foundation

public struct AnimalURL: Decodable {
    public let url: String
}

public func getAnimals(_ link: String) async -> [String]? {
           do {
        let url = URL(string: link)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode([AnimalURL].self, from: data)
        return decodedData.map { $0.url }
    } catch {
        print("Error fetching animals: \(error)")
        return nil
    }
}


