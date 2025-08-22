import SwiftUI

struct CardSetRowView: View {
    @Environment(\.appTheme) var theme
    @State private var containerLeft: CGFloat = 0
    @State private var containerWidth: CGFloat = 0
    @State private var itemWidth: CGFloat = 0
    let lorcanaSet: LorcanaSet
    let openCardSetDetailView: () -> Void
    let onCardTapped: (LorcanaCard) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Set title
            Button(action: {
                openCardSetDetailView()
            }) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(lorcanaSet.setName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(theme.primaryColor)
                        
                        Text("Set \(lorcanaSet.setNum)")
                            .font(.caption)
                            .foregroundColor(theme.secondaryColor)
                    }
                    
                    Spacer()
                    
                    Text("\(lorcanaSet.cards.count) cards")
                        .font(.caption)
                        .foregroundColor(theme.secondaryColor)
                        .padding(.horizontal, theme.padding)
                        .padding(.vertical, 4)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
            // Horizontally scrollable card items
            ScrollView(.horizontal, showsIndicators: false)  {
                HStack(spacing: 12) {
                    ForEach(Array(getDisplayCards().prefix(12)), id: \.uniqueID) { card in
                        GeometryReader { itemGeometry in
                            LorcanaCardView(card: card, showLabel: false)
                                .frame(width: 100, height: 140)
                                .scaleEffect(scaleFactor(containerLeft: containerLeft, itemGeometry: itemGeometry))
                                .onTapGesture {
                                    onCardTapped(card)
                                }
                        }
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 175, maxHeight: .infinity)
                    }
                    
                    ViewAllTile {
                        openCardSetDetailView()
                    }
                    
                }
                .padding(theme.padding)
            }
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.frame(in: .global).minX
            } action: { left in
                let calculatedLeft = left + theme.padding
                if(!calculatedLeft.isEqual(to: containerLeft)) {
                    containerLeft = calculatedLeft

                }
            }
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.frame(in: .global).width
            } action: { width in
                containerWidth = (width - itemWidth)
                print("width: \(width), itemWidth: \(itemWidth)")
            }
        }
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
    
    private func scaleFactor(containerLeft: CGFloat, itemGeometry: GeometryProxy) -> CGFloat {
        let itemCenter = (itemGeometry.size.width) / 2 + itemGeometry.frame(in: .global).minX
        let itemWidth = itemGeometry.size.width
        let scaleDistance = itemWidth / 2
        let scalePoint = containerLeft + scaleDistance
        let distance = abs(scalePoint - itemCenter)
        
        // kick back 1 if card is not in center range
        if distance > scaleDistance {
            return 1
        }
        
        let scaleFactor = (scaleDistance - (scaleDistance - distance)) / scaleDistance
        return ((1-scaleFactor) * 0.2) + 1
    }
}
