import SwiftUI

struct CardSetDetailView: View {
    @StateObject private var viewModel: CardSetDetailViewModel
    @Environment(\.dismiss) private var dismiss
    let onDismiss: () -> Void
    
    private let minimumCardWidth: CGFloat = 180
    
    init(setName: String, setNumber: Int, cards: [LorcanaCard], onDismiss: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: CardSetDetailViewModel(setName: setName, setNumber: setNumber, cards: cards))
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        VStack {
                // Search and filter bar
                HStack {
                    TextField("Search cards...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Filter", selection: $viewModel.selectedFilter) {
                        ForEach(CardSetDetailViewModel.CardFilter.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                }
                .padding(.horizontal)
                
                // Results count
                HStack {
                    Text("Showing \(viewModel.filteredCardCount) of \(viewModel.totalCardCount) cards")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Picker("Sort", selection: $viewModel.sortOrder) {
                        ForEach(CardSetDetailViewModel.SortOrder.allCases, id: \.self) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .font(.caption)
                }
                .padding(.horizontal)
                
                GeometryReader { geometry in
                    let columns = Array(
                        repeating: GridItem(.flexible(minimum: minimumCardWidth), spacing: 16),
                        count: max(1, Int(geometry.size.width / minimumCardWidth))
                    )
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredAndSortedCards, id: \.id) { card in
                                LorcanaCardView(card: card)
                                    .aspectRatio(5/7, contentMode: .fit)
                                    .onTapGesture {
                                        viewModel.selectCard(card)
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
        .navigationTitle(viewModel.displayTitle)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $viewModel.showingFullScreenCard) {
            if let selectedCard = viewModel.selectedCard {
                FullScreenCardView(card: selectedCard) {
                    viewModel.dismissFullScreenCard()
                }
            }
        }
    }
}
