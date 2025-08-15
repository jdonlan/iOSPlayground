import SwiftUI

struct CardSetRowView: View {
    let lorcanaSet: LorcanaSet
    let openCardSetDetailView: () -> Void
    let onCardTapped: (LorcanaCard) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Set title
            Button(action: {
                openCardSetDetailView()
            }) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(lorcanaSet.setName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Set \(lorcanaSet.setNum)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(lorcanaSet.cards.count) cards")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
            // Horizontally scrollable card items
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(getDisplayCards().prefix(12)), id: \.uniqueID) { card in
                        LorcanaCardView(card: card)
                            .onTapGesture {
                                onCardTapped(card)
                            }
                    }
                    
                    if lorcanaSet.cards.count > 12 {
                        ViewAllTile {
                            openCardSetDetailView()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func getDisplayCards() -> [LorcanaCard] {
        // Filter for legendary cards first
        let legendaryCards = lorcanaSet.cards.filter { card in
            card.rarity?.lowercased() == "legendary"
        }
        
        // Group by color and take 2 from each
        let cardsByColor = Dictionary(grouping: legendaryCards) { card in
            card.color ?? "Unknown"
        }
        
        var displayCards: [LorcanaCard] = []
        for (_, cards) in cardsByColor {
            displayCards.append(contentsOf: Array(cards.prefix(2)))
        }
        
        // If we don't have enough legendary cards, fill with remaining cards
        if displayCards.count < 12 {
            let remainingCards = lorcanaSet.cards.filter { card in
                !displayCards.contains(where: { $0.uniqueID == card.uniqueID })
            }
            displayCards.append(contentsOf: Array(remainingCards.prefix(12 - displayCards.count)))
        }
        
        return displayCards
    }
}