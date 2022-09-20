import SwiftUI
import CoreData

struct RegistrationCheckView: View {
    @State var numberPhoneRegistration:String = "+375"
    @ObservedObject var viewModel:FruitViewModel

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])

    var user: FetchedResults<UserRegEntity>

    
    var body: some View {
        VStack{
            HStack{
                Text("Вход или регистрация")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(.system(size: 20, weight: .light, design: .serif))
                    .padding()
                Spacer()
                Button {
                    self.viewModel.userRegShow = false
                } label: {
                    Image(systemName: "x.square")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.black)
                }
                .offset(y:-10)
                .padding(.horizontal)
            }
            TextFieldView(text: $numberPhoneRegistration, placeholder: "")
            
            Button {
                //
            } label: {
                Text("Получить код")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            .padding(.bottom,70)

        }
    }
}

struct registrationCheckView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationCheckView(numberPhoneRegistration: "", viewModel: FruitViewModel())
    }
}
