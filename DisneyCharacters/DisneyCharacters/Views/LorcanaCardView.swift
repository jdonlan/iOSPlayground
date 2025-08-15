import SwiftUI
import Kingfisher

struct LorcanaCardView: View {
    let card: LorcanaCard
    
    var body: some View {
        VStack(spacing: 8) {
            // Card image
            KFImage(URL(string: card.image ?? ""))
                .resizable()
                .roundCorner(radius: .point(12))
                .serialize(as: .PNG)
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 140)
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
