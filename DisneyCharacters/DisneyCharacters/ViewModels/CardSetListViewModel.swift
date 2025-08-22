import Foundation
import SwiftUI
import Combine

@MainActor
class CardSetListViewModel: ObservableObject {
    @Published var lorcanaSets: [LorcanaSet] = []
    @Published var isLoading = false
    
    private let appDataManager = AppDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupDataObservation()
        loadLorcanaSets()
    }
    
    private func setupDataObservation() {
        // Listen for changes in card count and loading state
        appDataManager.$cardCount
            .combineLatest(appDataManager.$isLoadingCards, appDataManager.$hasLoadedCards)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] cardCount, isLoadingCards, hasLoadedCards in
                // Refresh UI when data sync completes
                if !isLoadingCards && hasLoadedCards && cardCount > 0 {
                    self?.loadLorcanaSets()
                }
            }
            .store(in: &cancellables)
    }
    
    func loadLorcanaSets() {
        isLoading = true
        
        Task {
            let allCards = await appDataManager.getAllCards()
            let sets = LorcanaSet.groupCardsBySets(allCards)
            
            await MainActor.run {
                self.lorcanaSets = sets
                self.isLoading = false
            }
        }
    }
    
    func refreshSets() {
        Task {
            await appDataManager.refreshCards()
            // loadLorcanaSets will be called automatically via setupDataObservation
        }
    }
}
