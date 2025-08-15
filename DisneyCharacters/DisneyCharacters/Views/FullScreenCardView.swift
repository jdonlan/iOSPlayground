import SwiftUI
import Kingfisher

struct FullScreenCardView: View {
    let card: LorcanaCard
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            // Black background
            Color.black
                .ignoresSafeArea(.all)
                .onTapGesture {
                    onDismiss()
                }
            
            // Card image with 5% padding
            KFImage(URL(string: card.image ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all, 20) // 5% padding approximation
            
            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button("✕") {
                        onDismiss()
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                }
                Spacer()
            }
        }
    }
}