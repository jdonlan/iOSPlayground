import SwiftUI
import Kingfisher

struct LorcanaCardView: View {
    @StateObject private var viewModel: LorcanaCardViewModel
    
    init(card: LorcanaCard) {
        self._viewModel = StateObject(wrappedValue: LorcanaCardViewModel(card: card))
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Card image
            KFImage(viewModel.cardImageURL)
                .onSuccess { _ in
                    viewModel.onImageLoadSuccess()
                }
                .onFailure { error in
                    viewModel.onImageLoadFailure(error)
                }
                .placeholder {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .scaleEffect(0.8)
                        )
                }
                .resizable()
                .roundCorner(radius: .widthFraction(0.05))
                .serialize(as: .PNG)
                .aspectRatio(contentMode: .fill)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            // Card name
            Text(viewModel.cardName)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 2)
        }
        .padding(.horizontal, 4)
    }
}
