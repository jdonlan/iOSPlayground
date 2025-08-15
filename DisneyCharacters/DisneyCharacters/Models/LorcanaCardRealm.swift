import Foundation
import RealmSwift

class LorcanaCardRealm: Object {
    @Persisted var artist: String?
    @Persisted var setName: String?
    @Persisted var classifications: String?
    @Persisted var dateAdded: String?
    @Persisted var setNum: Int?
    @Persisted var color: String?
    @Persisted var gamemode: String?
    @Persisted var franchise: String?
    @Persisted var image: String?
    @Persisted var cost: Int?
    @Persisted var inkable: Bool = false
    @Persisted var name: String = ""
    @Persisted var type: String?
    @Persisted var lore: Int?
    @Persisted var rarity: String?
    @Persisted var uniqueID: String = ""
    @Persisted var cardNum: Int?
    @Persisted var bodyText: String?
    @Persisted var willpower: Int?
    @Persisted var strength: Int?
    @Persisted var abilities: String?
    @Persisted var flavorText: String?
    @Persisted var dateModified: String?
    @Persisted var setID: String?
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(from lorcanaCard: LorcanaCard) {
        self.init()
        self.artist = lorcanaCard.artist
        self.setName = lorcanaCard.setName
        self.classifications = lorcanaCard.classifications
        self.dateAdded = lorcanaCard.dateAdded
        self.setNum = lorcanaCard.setNum
        self.color = lorcanaCard.color
        self.gamemode = lorcanaCard.gamemode
        self.franchise = lorcanaCard.franchise
        self.image = lorcanaCard.image
        self.cost = lorcanaCard.cost
        self.inkable = lorcanaCard.inkable ?? false
        self.name = lorcanaCard.name
        self.type = lorcanaCard.type
        self.lore = lorcanaCard.lore
        self.rarity = lorcanaCard.rarity
        self.uniqueID = lorcanaCard.uniqueID
        self.cardNum = lorcanaCard.cardNum
        self.bodyText = lorcanaCard.bodyText
        self.willpower = lorcanaCard.willpower
        self.strength = lorcanaCard.strength
        self.abilities = lorcanaCard.abilities
        self.flavorText = lorcanaCard.flavorText
        self.dateModified = lorcanaCard.dateModified
        self.setID = lorcanaCard.setID
    }
    
    func toLorcanaCard() -> LorcanaCard {
        return LorcanaCard(
            artist: self.artist,
            setName: self.setName,
            classifications: self.classifications,
            dateAdded: self.dateAdded,
            setNum: self.setNum,
            color: self.color,
            gamemode: self.gamemode,
            franchise: self.franchise,
            image: self.image,
            cost: self.cost,
            inkable: self.inkable,
            name: self.name,
            type: self.type,
            lore: self.lore,
            rarity: self.rarity,
            uniqueID: self.uniqueID,
            cardNum: self.cardNum,
            bodyText: self.bodyText,
            willpower: self.willpower,
            strength: self.strength,
            abilities: self.abilities,
            flavorText: self.flavorText,
            dateModified: self.dateModified,
            setID: self.setID
        )
    }
}