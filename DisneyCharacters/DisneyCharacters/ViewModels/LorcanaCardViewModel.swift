import Foundation
import SwiftUI
import Combine

@MainActor
class LorcanaCardViewModel: ObservableObject {
    @Published var isImageLoading = true
    @Published var imageLoadError: Error?
    
    private let card: LorcanaCard
    
    init(card: LorcanaCard) {
        self.card = card
    }
    
    var cardName: String {
        card.name
    }
    
    var cardImageURL: URL? {
        URL(string: card.image ?? "")
    }
    
    var cardRarity: String {
        card.rarity ?? "Unknown"
    }
    
    var rarityEmoji: String {
        card.rarityEmoji
    }
    
    var cardColor: String {
        card.color ?? "Unknown"
    }
    
    var cardCost: Int {
        card.cost ?? 0
    }
    
    var cardType: String {
        card.type ?? "Unknown"
    }
    
    var cardText: String {
        card.bodyText ?? ""
    }
    
    func onImageLoadSuccess() {
        isImageLoading = false
        imageLoadError = nil
    }
    
    func onImageLoadFailure(_ error: Error) {
        isImageLoading = false
        imageLoadError = error
    }
    
    func resetImageState() {
        isImageLoading = true
        imageLoadError = nil
    }
}