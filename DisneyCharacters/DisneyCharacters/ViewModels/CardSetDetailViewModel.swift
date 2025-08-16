import Foundation
import SwiftUI
import Combine

@MainActor
class CardSetDetailViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var selectedCard: LorcanaCard?
    @Published var showingFullScreenCard = false
    @Published var searchText = ""
    @Published var selectedFilter: CardFilter = .all
    @Published var sortOrder: SortOrder = .name
    
    private let setName: String
    private let setNumber: Int
    private let allCards: [LorcanaCard]
    
    enum CardFilter: String, CaseIterable {
        case all = "All"
        case common = "Common"
        case uncommon = "Uncommon" 
        case rare = "Rare"
        case superRare = "Super Rare"
        case legendary = "Legendary"
        case enchanted = "Enchanted"
    }
    
    enum SortOrder: String, CaseIterable {
        case name = "Name"
        case rarity = "Rarity"
        case cost = "Cost"
        case color = "Color"
    }
    
    init(setName: String, setNumber: Int, cards: [LorcanaCard]) {
        self.setName = setName
        self.setNumber = setNumber
        self.allCards = cards
    }
    
    var displayTitle: String {
        setName
    }
    
    var totalCardCount: Int {
        allCards.count
    }
    
    var filteredCardCount: Int {
        filteredAndSortedCards.count
    }
    
    var filteredAndSortedCards: [LorcanaCard] {
        var cards = allCards
        
        // Apply search filter
        if !searchText.isEmpty {
            cards = cards.filter { card in
                card.name.localizedCaseInsensitiveContains(searchText) ||
                (card.bodyText ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply rarity filter
        if selectedFilter != .all {
            cards = cards.filter { card in
                card.rarity?.lowercased() == selectedFilter.rawValue.lowercased()
            }
        }
        
        // Apply sorting
        switch sortOrder {
        case .name:
            cards = cards.sorted { $0.name < $1.name }
        case .rarity:
            cards = cards.sorted { (card1, card2) in
                let rarityOrder = ["common", "uncommon", "rare", "super rare", "legendary", "enchanted"]
                let rarity1 = card1.rarity?.lowercased() ?? ""
                let rarity2 = card2.rarity?.lowercased() ?? ""
                let index1 = rarityOrder.firstIndex(of: rarity1) ?? 0
                let index2 = rarityOrder.firstIndex(of: rarity2) ?? 0
                return index1 < index2
            }
        case .cost:
            cards = cards.sorted { ($0.cost ?? 0) < ($1.cost ?? 0) }
        case .color:
            cards = cards.sorted { ($0.color ?? "") < ($1.color ?? "") }
        }
        
        return cards
    }
    
    func selectCard(_ card: LorcanaCard) {
        selectedCard = card
        showingFullScreenCard = true
    }
    
    func dismissFullScreenCard() {
        showingFullScreenCard = false
        selectedCard = nil
    }
    
    func clearSearch() {
        searchText = ""
    }
    
    func resetFilters() {
        searchText = ""
        selectedFilter = .all
        sortOrder = .name
    }
}