import SwiftUI

struct CategoriesCell: View {
    var nameImage = ""
    var nameCategories = ""
    var body: some View {
        ZStack{
            Image(nameImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 140)
            Color(.init(red: 0, green: 0, blue: 0, alpha: 0.4))
                .frame(width: 180, height: 140)
            Text(nameCategories)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(.white)
        }
        .background(.white)
        .cornerRadius(20)
    }
}

struct CategoriesCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesCell().previewLayout(.fixed(width: 150, height: 150))
    }
}
