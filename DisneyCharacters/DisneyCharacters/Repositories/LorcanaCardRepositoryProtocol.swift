import Foundation

protocol LorcanaCardRepositoryProtocol {
    @MainActor func getAllCards() async -> [LorcanaCard]
    @MainActor func getCards(by franchise: String) async -> [LorcanaCard]
    @MainActor func getCard(by uniqueID: String) async -> LorcanaCard?
    @MainActor func saveCards(_ cards: [LorcanaCard]) async throws
    @MainActor func clearAllCards() async throws
    @MainActor func getCardCount() async -> Int
    func syncCards() async throws
    
    // Convenience methods
    @MainActor func searchCards(by name: String) async -> [LorcanaCard]
    @MainActor func getCardsByRarity(_ rarity: String) async -> [LorcanaCard]
    @MainActor func getCardsByColor(_ color: String) async -> [LorcanaCard]
    @MainActor func getCharacterCards() async -> [LorcanaCard]
}