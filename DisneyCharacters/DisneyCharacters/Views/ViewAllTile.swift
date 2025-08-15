import SwiftUI

struct ViewAllTile: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 100, height: 140)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "square.grid.2x2")
                                .font(.title2)
                                .foregroundColor(.primary)
                            Text("View All")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                    )
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                
                Text("")
                    .font(.caption)
                    .frame(width: 100, height: 24)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 4)
    }
}