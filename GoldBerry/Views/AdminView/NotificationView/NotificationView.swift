import SwiftUI

struct NotificationView: View {
    var body: some View {
        Text("В разработке, мы это скоро сделаем!!")
            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
            .foregroundColor(Color.theme.blackWhiteText)
            .padding(.bottom, 10)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
