import SwiftUI

struct AddFruit: View {
    @ObservedObject var adminViewModel: AdminViewModel
    @State var productName = ""
    @State var productDescription = ""
    @State var productPrice = ""
    @State var productDiscount = ""
    @State var productCategories = ""
    var body: some View {
        VStack {
            HStack {
                Button {
                    adminViewModel.showAddFruit = false
                    adminViewModel.showUpdate = false
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundColor(.white)
                }
                Spacer()
                Button {
                    let addFruit = Fruit(cost: Double(productPrice) ?? 0,
                                         weightOrPieces: "кг",
                                         categories: productCategories,
                                         favorite: false,
                                         count: 1,
                                         image: "",
                                         name: productName,
                                         percent: Int(productDiscount) ?? 0,
                                         comment: productDescription,
                                         stepCount: 1)
                    Task {
                        do {
                            try await adminViewModel.addFruit(fruits: addFruit)
                            adminViewModel.showAddFruit = false

                            adminViewModel.selected = 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                self.adminViewModel.selected = 0
                            }
                        } catch {}
                    }

                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(Color.theme.lightGreen)
            VStack {
                Button {
                    //
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color.theme.lightGreen)
                        .frame(width: 60, height: 60, alignment: .center)
                }
                .frame(width: 300, height: 150)
                .background(.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.gray, lineWidth: 2)
                )
                .cornerRadius(20)
            }
            .padding(.top, 30)
            TextFieldView(text: $productName, placeholder: "Наименование (до 20 символов) ", infoText: "")
                .disabled(productName.count > 20)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $productDescription)
                    .disabled(productDescription.count > 100)
                    .lineLimit(7)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                    .background(.clear)
                    .padding(.leading, 20)
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                    )
                    .padding()
                if productDescription.isEmpty {
                    Text("Описание товара (до 100 символов)")
                        .padding(.top, 10)
                        .foregroundColor(.gray.opacity(0.5))
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .padding(.leading, 20)
                        .padding()
                }
            }

            TextFieldView(text: $productPrice, placeholder: "Стоймость, руб ", infoText: "")
                .keyboardType(.numbersAndPunctuation)
            HStack {
                TextFieldView(text: $productDiscount, placeholder: "Скидка", infoText: "")
                    .keyboardType(.numbersAndPunctuation)
                    .frame(width: 150)
                Text("%")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                Spacer()
            }

            Picker("", selection: $productCategories) {
                Text("Арбуз и дыни").tag(CategoriesFruit.all.rawValue)
                Text("Гранат").tag(CategoriesFruit.granat.rawValue)
                Text("Фрукты").tag(CategoriesFruit.fruct.rawValue)
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            Spacer()
        }
    }
}
