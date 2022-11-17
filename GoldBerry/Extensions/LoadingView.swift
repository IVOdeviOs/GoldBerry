import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(.automatic)
                .tint(.red)
                .frame(width: 40, height: 40)
        }
    }
}

extension View {
    @ViewBuilder
    func isLoading(_ isLoading: Bool) -> some View {
        ZStack {
            self
            if isLoading {
                LoadingView()
            }
        }
        .animation(.linear(duration: 0.2), value: isLoading)
    }
}
