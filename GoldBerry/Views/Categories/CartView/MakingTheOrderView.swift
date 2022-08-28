import SwiftUI

struct MakingTheOrderView: View {
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            
        Text("Оформление заказа")
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 18, height: 18)
         .foregroundColor(.black)
            .onTapGesture {
               self.presentation.wrappedValue.dismiss()
            }
         )
    }
}

struct MakingTheOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MakingTheOrderView()
    }
}
