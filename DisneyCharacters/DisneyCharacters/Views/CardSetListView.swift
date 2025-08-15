import SwiftUI

struct CardSetListView: View {
    @StateObject private var viewModel = CardSetListViewModel()
    @EnvironmentObject var appDataManager: AppDataManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading || appDataManager.isLoadingCards {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        
                        if appDataManager.isLoadingCards {
                            Text("Downloading latest cards...")
                                .font(.headline)
                                .foregroundColor(.primary)
                        } else {
                            Text("Loading Lorcana Cards...")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        if appDataManager.cardCount > 0 {
                            Text("Current: \(appDataManager.cardCount) cards")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if let lastSync = appDataManager.lastSyncDate {
                            Text("Last updated: \(lastSync.formatted(.dateTime.hour().minute()))")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                } else if viewModel.lorcanaSets.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.stack")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        
                        Text("No Lorcana Sets")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Pull to refresh to load card data")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(viewModel.lorcanaSets) { lorcanaSet in
                                CardSetRowView(lorcanaSet: lorcanaSet)
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
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CardSetListView()
}