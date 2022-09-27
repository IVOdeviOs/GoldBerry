//import SwiftUI
//
//struct AuthCodeRegistrationView: View {
//    @ObservedObject var reg: FireBaseLogin
//    @Environment(\.presentationMode) var present
//    var body: some View {
//        VStack{
//            VStack{
//                HStack{
//                    Button {
//                        present.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "arrow.left")
//                            .font(.title2)
//                            .foregroundColor(.black)
//                        
//                    }
//                    Spacer()
//                    Text("Verification phone")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                    Spacer()
//                    if reg.loading{ProgressView()}
//                }
//                .padding()
//                Text("Code sent to \(reg.phoneNumber)")
//                    .foregroundColor(.gray)
//                    .padding()
//                Spacer(minLength: 0)
//                HStack(spacing: 10) {
////                    ForEach(0..<6,id: \.self){ index in
//                    CodeView(reg: reg)
//                        
//                        
////                    }
//                    
//                    
//                }
//                .padding()
//                .padding(.horizontal,20)
//                Spacer(minLength: 0)
//                HStack(spacing: 6) {
//                    Text("Didn't receive code?")
//                        .foregroundColor(.gray)
//                    
//                    Button {
//                        reg.requestCode()
//                    } label: {
//                        Text("Request Again")
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//                    }
//                    Button {
//                        //
//                    } label: {
//                        Text("Get via call")
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//                    }
//                    .padding(.top,6)
//                 
//
//                }
//                Button {
//
//                    reg.verifyCode()
//                    print("\(reg.code)🥶")
//
//                } label: {
//                    Text("Verify and Created Account")
//                        .foregroundColor(.black)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 30)
//                        .background(.yellow)
//                        .cornerRadius(15)
//                }
//                
//                
//            }
//            .frame(height: UIScreen.main.bounds.height/1.8)
//            .background(Color.white)
//            .cornerRadius(20)
//            Spacer()
//            
//        }
//        .background(.green.opacity(0.3)).ignoresSafeArea(.all,edges: .bottom)
//        .sheet(isPresented: $reg.error, content: {
//        AlertView(msg: reg.errorMSG, show: $reg.error)
//    })
//    }
//     
//   
////    func getCodeAtIndex(index:Int)-> String{
////        if reg.phoneNumber.count > index{
////            let start = reg.code.startIndex
////
////            let current = reg.code.index(start,offsetBy: index)
////            return String(reg.code[current])
////        }
////        return ""
////    }
//    
//}
//
//struct AuthCodeRegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthCodeRegistrationView(reg: FireBaseLogin())
//    }
//}
//
//struct CodeView:View{
//    @ObservedObject var reg: FireBaseLogin
//
//    var body: some View{
//        VStack(spacing: 10) {
//            TextFieldView(text: $reg.code, text1: "")
//                .foregroundColor(.black)
////                .fontWeight(.bold)
//                .font(.title2)
//                .frame(height: 45)
//            Capsule()
//                .fill(Color.gray.opacity(0.5))
//                .frame(height: 4)
//        }
//        
//    }
//    
//    
//}
