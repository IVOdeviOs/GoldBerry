
import SwiftUI

struct ShopsView: View {
    var body: some View {
        VStack {
            Text("Наши торговые точки")
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(15, .uzSansBold)))
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            Spacer()
        }
    }
}

struct ShopsView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView()
    }
}
