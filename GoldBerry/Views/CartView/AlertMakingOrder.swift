import SwiftUI

struct AlertMakingOrder: View {

    @ObservedObject var orderViewModel = OrderViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image("oops")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .padding()
                Text("Что-то пошло не так :(")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding(.bottom, 10)
                Text("Проверьте Ваше интернет-соединение")
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(Color.theme.gray)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct AlertMakingOrder_Previews: PreviewProvider {
    static var previews: some View {
        AlertMakingOrder()
    }
}
