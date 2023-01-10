import SwiftUI

struct TextFieldView: View {

    var text: Binding<String>
    var placeholder:LocalizedStringKey = ""
    var infoText: String
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TextField(placeholder, text: text)
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                    .padding(.leading, 20)
                    .background(.clear)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                    )
                    .padding()

                Text(infoText)
                    .padding(.leading, 30)
                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    .offset(y: -35)
                    .opacity(text.wrappedValue.isEmpty ? 1 : 0.5)
            }
        }.onTapGesture {
            HideKeyboard()
        }
    }
}
