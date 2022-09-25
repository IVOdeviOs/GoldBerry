import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
let countries = [
    "BY":"375",
    "RU":"7"
    
]


class FireBaseLogin:ObservableObject{
    @Published var phoneNumber = ""
    @Published var code = ""

    @Published var errorMSG = ""
    @Published var error = false
    
    @Published var CODE = ""
    @Published var gotoVerify = false
    @Published var loading = false
    @AppStorage("log_status") var status = false
    
    func getCountryCode()-> String{
        let regioneCode = Locale.current.regionCode ?? ""
        
        return countries[regioneCode] ?? ""
    }
    
    
    func sendCode(){
        
        
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
//        let number = "+\(getCountryCode())\(phoneNumber)"
        let number = phoneNumber
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE,err) in
            if let error = err{
                self.errorMSG = error.localizedDescription
                self.error.toggle()
                return
            }
            self.CODE = CODE!
            self.gotoVerify = true 
        }
       
        
    }
    func verifyCode(){
        print("\(String(status))")

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        loading = true
        Auth.auth().signIn(with: credential){ (result,err) in
            self.loading = false
            print("\(String(self.status))")

            if let error = err{
                self.errorMSG = error.localizedDescription
                self.error.toggle()
                return
            }
            withAnimation{self.status = true}
        }
        
        
    }
    func requestCode(){
        sendCode()
        withAnimation {
            self.errorMSG = "Code sent Successfully "
            self.error.toggle()
        }
        
        
    }
    
    
}
