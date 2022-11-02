import SwiftUI

struct TextFieldView: View {

    var text: Binding<String>
    var placeholder = ""
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
                        .padding(.leading,30)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .offset( y: -35)
                        .opacity(text.wrappedValue.isEmpty ? 0.5 : 1 )
                
            }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: Binding<String>.constant("nfdsjjsd"), placeholder: "sdss", infoText: "")
    }
}
