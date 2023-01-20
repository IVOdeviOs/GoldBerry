import SwiftUI

struct DisclaimerOfLiability: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Disclaimer of liability")
                    .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("""
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                """).multilineTextAlignment(.leading)
                    .padding()
                    .font(Font(uiFont: .fontLibrary(10, .uzSansRegular)))
                    .foregroundColor(Color.theme.blackWhiteText)
            }
        }
    }
}
