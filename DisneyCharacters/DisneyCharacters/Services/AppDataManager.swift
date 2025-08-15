import Foundation
import SwiftUI

@MainActor
class AppDataManager: ObservableObject {
    static let shared = AppDataManager()
    
    @Published var isLoadingCards = false
    @Published var hasLoadedCards = false
    @Published var cardCount = 0
    @Published var lastSyncDate: Date?
    @Published var syncError: Error?
    
    private let repository: LorcanaCardRepositoryProtocol
    private let userDefaults = UserDefaults.standard
    
    private let lastSyncKey = "lastLorcanaCardSync"
    private let hasInitialLoadKey = "hasInitialLorcanaCardLoad"
    
    init(repository: LorcanaCardRepositoryProtocol = LorcanaCardRepository()) {
        self.repository = repository
        self.lastSyncDate = userDefaults.object(forKey: lastSyncKey) as? Date
        self.hasLoadedCards = userDefaults.bool(forKey: hasInitialLoadKey)
    }
    
    func initializeAppData() async {
        print("🔄 Initializing app data...")
        
        // Test Realm connection
        RealmConnectionTest.testConnection()
        
        await updateCardCount()
        
        // If we've never loaded cards or it's been more than 24 hours, sync
        let shouldSync = !hasLoadedCards || shouldSyncCards()
        
        if shouldSync {
            await syncCards()
        }
    }
    
    func syncCards(force: Bool = false) async {
        guard !isLoadingCards || force else { return }
        
        isLoadingCards = true
        syncError = nil
        
        do {
            try await repository.syncCards()
            
            hasLoadedCards = true
            lastSyncDate = Date()
            
            userDefaults.set(lastSyncDate, forKey: lastSyncKey)
            userDefaults.set(true, forKey: hasInitialLoadKey)
            
            await updateCardCount()
            
        } catch {
            syncError = error
            print("❌ Failed to sync Lorcana cards: \(error)")
        }
        
        isLoadingCards = false
    }
    
    func refreshCards() async {
        await syncCards(force: true)
    }
    
    
    private func updateCardCount() async {
        cardCount = await repository.getCardCount()
    }
    
    private func shouldSyncCards() -> Bool {
        guard let lastSync = lastSyncDate else { return true }
        
        // Sync if it's been more than 24 hours
        let twentyFourHoursAgo = Date().addingTimeInterval(-24 * 60 * 60)
        return lastSync < twentyFourHoursAgo
    }
    
    // MARK: - Public Methods for accessing cards
    func getAllCards() async -> [LorcanaCard] {
        return await repository.getAllCards()
    }
    
    func getCards(by franchise: String) async -> [LorcanaCard] {
        return await repository.getCards(by: franchise)
    }
    
    func searchCards(by name: String) async -> [LorcanaCard] {
        return await repository.searchCards(by: name)
    }
}