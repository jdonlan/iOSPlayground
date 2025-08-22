import Foundation

struct LorcanaSet: Identifiable, Hashable {
    let id = UUID()
    let setNum: Int
    let setName: String
    let cards: [LorcanaCard]
}

extension LorcanaSet {
    func hash(into hasher: inout Hasher) {
        hasher.combine(setNum)
        hasher.combine(setName)
    }
    
    static func == (lhs: LorcanaSet, rhs: LorcanaSet) -> Bool {
        lhs.setNum == rhs.setNum && lhs.setName == rhs.setName
    }
    
    private struct SetKey: Hashable {
        let setNum: Int
        let setName: String
    }
    
    static func groupCardsBySets(_ cards: [LorcanaCard]) -> [LorcanaSet] {
        let grouped = Dictionary(grouping: cards) { card in
            SetKey(setNum: card.setNum ?? 0, setName: card.setName ?? "Unknown Set")
        }
        
        return grouped.compactMap { key, cards in
            guard key.setNum > 0 else { return nil }
            return LorcanaSet(setNum: key.setNum, setName: key.setName, cards: cards)
        }.sorted { $0.setNum < $1.setNum }
    }
}