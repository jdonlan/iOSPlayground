import SwiftUI

struct CharacterCardView: View {
    let card: LorcanaCard
    
    var body: some View {
        VStack(spacing: 8) {
            // Card image
            AsyncImage(url: URL(string: card.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .overlay(
                        VStack(spacing: 4) {
                            Image(systemName: "photo")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text(card.rarityEmoji)
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    )
            }
            .frame(width: 100, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            // Card name
            Text(card.name)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 100)
                .padding(.horizontal, 2)
        }
        .padding(.horizontal, 4)
    }
}