import SwiftUI

struct CardSetRowView: View {
    let lorcanaSet: LorcanaSet
    let openCardSetDetailView: () -> Void
    
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
                    ForEach(Array(lorcanaSet.cards.prefix(10)), id: \.uniqueID) { card in
                        LorcanaCardView(card: card)
                            .onTapGesture {
                                print("Tapped on \(card.name) from \(lorcanaSet.setName)")
                            }
                    }
                    
                    if lorcanaSet.cards.count > 10 {
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
}