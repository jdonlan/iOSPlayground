import SwiftUI

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
            
            // Card with 5% padding from screen edges
            LorcanaCardView(card: card)
                .aspectRatio(contentMode: .fit)
                .padding(.all, 20)
            
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