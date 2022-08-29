import SwiftUI

struct UserInfoView: View {
    
    @StateObject var viewModels: OrderViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModels: OrderViewModel())
    }
}
