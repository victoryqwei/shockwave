import Combine

extension Set where Element: Cancellable {
    func cancel() {
        forEach { $0.cancel() }
    }
}
