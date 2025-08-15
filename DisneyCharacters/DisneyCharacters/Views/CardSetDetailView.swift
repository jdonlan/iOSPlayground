import SwiftUI

struct CardSetDetailView: View {
    let setName: String
    let setNumber: Int
    let cards: [LorcanaCard]
    let onDismiss: () -> Void
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cards, id: \.id) { card in
                        LorcanaCardView(card: card)
                    }
                }
                .padding()
            }
            .navigationTitle(setName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("✕") {
                        onDismiss()
                    }
                }
            }
        }
    }
}