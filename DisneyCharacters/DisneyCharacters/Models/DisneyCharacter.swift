import Foundation

struct DisneyCharacter: Identifiable {
    let id = UUID()
    let name: String
    let movie: String
    let description: String
}

struct Movie: Identifiable {
    let id = UUID()
    let name: String
    let characters: [DisneyCharacter]
}

extension DisneyCharacter {
    static let mockData: [DisneyCharacter] = [
        // Frozen
        DisneyCharacter(name: "Elsa", movie: "Frozen", description: "The Snow Queen with magical powers"),
        DisneyCharacter(name: "Anna", movie: "Frozen", description: "A fearless optimist with a warm heart"),
        DisneyCharacter(name: "Olaf", movie: "Frozen", description: "A cheerful snowman who loves warm hugs"),
        
        // Toy Story
        DisneyCharacter(name: "Woody", movie: "Toy Story", description: "A cowboy toy who leads the group"),
        DisneyCharacter(name: "Buzz Lightyear", movie: "Toy Story", description: "A space ranger action figure"),
        DisneyCharacter(name: "Rex", movie: "Toy Story", description: "A nervous but loveable T-Rex"),
        
        // The Lion King
        DisneyCharacter(name: "Simba", movie: "The Lion King", description: "The brave lion who becomes king"),
        DisneyCharacter(name: "Mufasa", movie: "The Lion King", description: "A wise and noble lion king"),
        DisneyCharacter(name: "Timon", movie: "The Lion King", description: "A witty meerkat with no worries"),
        DisneyCharacter(name: "Pumbaa", movie: "The Lion King", description: "A friendly warthog"),
        
        // The Little Mermaid
        DisneyCharacter(name: "Ariel", movie: "The Little Mermaid", description: "A curious mermaid who dreams of the surface world"),
        DisneyCharacter(name: "Sebastian", movie: "The Little Mermaid", description: "A Caribbean crab and musical advisor"),
        
        // Beauty and the Beast
        DisneyCharacter(name: "Belle", movie: "Beauty and the Beast", description: "A book-loving girl who sees beyond appearances"),
        DisneyCharacter(name: "Beast", movie: "Beauty and the Beast", description: "A cursed prince with a kind heart"),
        
        // Aladdin
        DisneyCharacter(name: "Aladdin", movie: "Aladdin", description: "A street-smart young man with a magic lamp"),
        DisneyCharacter(name: "Jasmine", movie: "Aladdin", description: "A strong-willed princess"),
        DisneyCharacter(name: "Genie", movie: "Aladdin", description: "A magical being with incredible powers"),
        
        // Moana
        DisneyCharacter(name: "Moana", movie: "Moana", description: "A brave Polynesian girl who sails across the ocean"),
        DisneyCharacter(name: "Maui", movie: "Moana", description: "A shapeshifting demigod"),
        
        // Tangled
        DisneyCharacter(name: "Rapunzel", movie: "Tangled", description: "A princess with magical long hair"),
        DisneyCharacter(name: "Flynn Rider", movie: "Tangled", description: "A charming thief with a good heart")
    ]
}