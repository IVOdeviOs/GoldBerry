import SwiftUI

struct TextFieldView: View {
    
    var text: Binding<String>
    var placeholder: String = ""
    var text1: String
    var body: some View {
        VStack {
           
            TextField(placeholder, text: text,prompt: Text(text1).bold().foregroundColor(.black))
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .padding(.leading, 20)
                .background(.white)
                .frame(height: 50)
//                .border(.red, width: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                )
//                .cornerRadius(10)
                .padding()
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: Binding<String>.constant("dddd"), placeholder: "sdss", text1: "")
    }
}
