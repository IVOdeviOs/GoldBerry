
enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    case add
    case update(User)
}
