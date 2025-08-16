import SwiftUI
import Kingfisher

struct CardSetListView: View {
    @Environment(\.appTheme) var theme
    @StateObject private var viewModel = CardSetListViewModel()
    @EnvironmentObject var appDataManager: AppDataManager
    @State private var selectedSet: LorcanaSet?
    @State private var selectedCard: LorcanaCard?

    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("cabg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: (!viewModel.isLoading && !appDataManager.isLoadingCards && !viewModel.lorcanaSets.isEmpty) ? 10 : 0)
                
                // Surface color scrim overlay when content is loaded
                if !viewModel.isLoading && !appDataManager.isLoadingCards && !viewModel.lorcanaSets.isEmpty {
                    Color(theme.surfaceColor)
                        .opacity(0.5)
                        .ignoresSafeArea()
                }
                
                if viewModel.isLoading || appDataManager.isLoadingCards {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        
                        if appDataManager.isLoadingCards {
                            Text("Downloading latest cards...")
                                .font(.headline)
                                .foregroundColor(theme.primaryColor)
                        } else {
                            Text("Loading Lorcana Cards...")
                                .font(.headline)
                                .foregroundColor(theme.primaryColor)
                        }
                        
                        if appDataManager.cardCount > 0 {
                            Text("Current: \(appDataManager.cardCount) cards")
                                .font(.caption)
                                .foregroundColor(theme.primaryColor)
                        }
                        
                        if let lastSync = appDataManager.lastSyncDate {
                            Text("Last updated: \(lastSync.formatted(.dateTime.hour().minute()))")
                                .font(.caption2)
                                .foregroundColor(theme.primaryColor)
                        }
                    }
                } else if viewModel.lorcanaSets.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.stack")
                            .font(.system(size: 48))
                            .foregroundColor(theme.primaryColor)
                        
                        Text("No Lorcana Sets")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(theme.primaryColor)
                        
                        Text("Pull to refresh to load card data")
                            .font(.body)
                            .foregroundColor(theme.primaryColor)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(viewModel.lorcanaSets) { lorcanaSet in
                                CardSetRowView(
                                    lorcanaSet: lorcanaSet,
                                    openCardSetDetailView: {
                                        selectedSet = lorcanaSet
                                    },
                                    onCardTapped: { card in
                                        selectedCard = card
                                    }
                                )
                            }
                        }
                        .padding(.top)
                    }
                    .refreshable {
                        viewModel.refreshSets()
                    }
                }
            }
            .navigationTitle("Lorcana Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                LorcanaToolbar()
            }
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .sheet(item: $selectedSet) { lorcanaSet in
                CardSetDetailView(
                    setName: lorcanaSet.setName,
                    setNumber: lorcanaSet.setNum,
                    cards: lorcanaSet.cards
                ) {
                    selectedSet = nil
                }
            }
            .fullScreenCover(item: $selectedCard) { lorcanaCard in
                FullScreenCardView(card: lorcanaCard) {
                    selectedCard = nil
                }
            }
        }
    }
}

#Preview {
    CardSetListView()
}
