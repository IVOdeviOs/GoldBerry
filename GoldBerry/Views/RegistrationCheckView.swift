import CoreData
import Firebase
import FirebaseAuth
import SwiftUI
struct RegistrationCheckView: View {
    @ObservedObject var reg = FireBaseLogin()
    @State var numberPhoneRegistration = ""
    @State var prefix: String

    @ObservedObject var viewModel: FruitViewModel

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])

    var user: FetchedResults<UserRegEntity>

    var body: some View {

        VStack {
            HStack {
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
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
                .offset(y: -10)
                .padding(.horizontal)
            }

            TextFieldView(text: $reg.phoneNumber, placeholder: "", text1: prefix)

            Button {

                reg.sendCode()

            } label: {
                Text("Получить код")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            .padding(.bottom, 70)
        }
        
        .sheet(isPresented: $reg.gotoVerify) {
            AuthCodeRegistrationView(reg: reg)
        }
    }
}

struct registrationCheckView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationCheckView(numberPhoneRegistration: "", prefix: "", viewModel: FruitViewModel())
    }
}
