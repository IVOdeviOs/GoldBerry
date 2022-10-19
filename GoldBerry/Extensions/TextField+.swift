import SwiftUI

struct TextFieldView: View {

    var text: Binding<String>
    var placeholder = ""
    var body: some View {
        VStack {
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
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: Binding<String>.constant("dddd"), placeholder: "sdss")
    }
}
