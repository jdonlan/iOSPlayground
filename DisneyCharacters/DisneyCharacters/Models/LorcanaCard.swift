import Foundation

struct LorcanaCard: Codable, Identifiable {
    let artist: String?
    let setName: String?
    let classifications: String?
    let dateAdded: String?
    let setNum: Int?
    let color: String?
    let gamemode: String?
    let franchise: String?
    let image: String?
    let cost: Int?
    let inkable: Bool?
    let name: String
    let type: String?
    let lore: Int?
    let rarity: String?
    let uniqueID: String
    let cardNum: Int?
    let bodyText: String?
    let willpower: Int?
    let strength: Int?
    let abilities: String?
    let flavorText: String?
    let dateModified: String?
    let setID: String?
    
    var id: String { uniqueID }
    
    enum CodingKeys: String, CodingKey {
        case artist = "Artist"
        case setName = "Set_Name"
        case classifications = "Classifications"
        case dateAdded = "Date_Added"
        case setNum = "Set_Num"
        case color = "Color"
        case gamemode = "Gamemode"
        case franchise = "Franchise"
        case image = "Image"
        case cost = "Cost"
        case inkable = "Inkable"
        case name = "Name"
        case type = "Type"
        case lore = "Lore"
        case rarity = "Rarity"
        case uniqueID = "Unique_ID"
        case cardNum = "Card_Num"
        case bodyText = "Body_Text"
        case willpower = "Willpower"
        case strength = "Strength"
        case abilities = "Abilities"
        case flavorText = "Flavor_Text"
        case dateModified = "Date_Modified"
        case setID = "Set_ID"
    }
}

extension LorcanaCard {
    var inkColors: [String] {
        color?.components(separatedBy: " - ") ?? []
    }
    
    var isCharacter: Bool {
        type?.lowercased() == "character"
    }
    
    var displayName: String {
        name
    }
    
    var costDescription: String {
        guard let cost = cost else { return "Unknown" }
        return "\(cost) ink"
    }
    
    var rarityEmoji: String {
        switch rarity?.lowercased() {
        case "common": return "●"
        case "uncommon": return "📖"
        case "rare": return "▲"
        case "super rare": return "◆"
        case "legendary": return "⬟"
        case "enchanted": return "⬡"
        default: return "❓"
        }
    }
}