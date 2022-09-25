import SwiftUI

struct AlertView: View {
    var msg:String
    @Binding var show:Bool
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Text(msg)
                .foregroundColor(.gray)
            
            Button {
                withAnimation{
                    show.toggle()
                }
            } label: {
                Text("Close")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color(.yellow))
                    .cornerRadius(15)
            }
            .frame(alignment: .center)

        }
    }
}


