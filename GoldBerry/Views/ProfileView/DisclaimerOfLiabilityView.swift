import SwiftUI

struct DisclaimerOfLiability: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Отказ от ответственности")
                    .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("""
                  

""").multilineTextAlignment(.leading)
                .padding()
                    .font(Font(uiFont: .fontLibrary(10, .uzSansRegular)))
                    .foregroundColor(.black)
            }
        }
    }
}

struct DisclaimerOfLiability_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerOfLiability()
    }
}
