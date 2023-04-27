import SwiftUI

struct CategoriesCell: View {
    var nameImage = ""
    var nameCategories: LocalizedStringKey = ""
    var body: some View {
        ZStack {
            Image(nameImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 100)
            Color(.init(red: 0, green: 0, blue: 0, alpha: 0.4))
                .frame(width: 150, height: 100)
            Text(nameCategories)
                .font(Font(uiFont: .fontLibrary(18, .pFBeauSansProSemiBold)))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 100)
        .background(.white)
        .cornerRadius(20)
    }
}

struct CategoriesCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesCell().previewLayout(.fixed(width: 150, height: 150))
    }
}
