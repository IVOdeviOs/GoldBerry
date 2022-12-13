import SwiftUI

struct AddFruit: View {
    @ObservedObject var adminViewModel: AdminViewModel
    @State var idFruit = UUID()
    @State var productName = ""
    @State var productDescription = ""
    @State var productPrice = ""
    @State var productDiscount = ""
    @State var productCategories = ""
    @State var weightOrPieces = ""
    @State var productImage = ""
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            HStack {
                Button {
                    adminViewModel.showAddFruit = false
                    self.presentation.wrappedValue.dismiss()

                } label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundColor(.white)
                }
                Spacer()
                if productName.isEmpty || productPrice.isEmpty || productDescription.isEmpty || productDiscount.isEmpty || productCategories.isEmpty {} else {
                    Button {
                        adminViewModel.saveImageFirebaseStorageURL()

                        let addFruit = Fruit(id: idFruit,
                                             cost: Double(productPrice) ?? 0,
                                             weightOrPieces: weightOrPieces,
                                             categories: productCategories,
                                             favorite: false,
                                             count: 1,
                                             image: adminViewModel.urlImageString,
                                             name: productName,
                                             percent: Int(productDiscount) ?? 0,
                                             comment: productDescription,
                                             stepCount: 1)

                        Task {
                            do {
                                if adminViewModel.isUpdating {
                                    try await adminViewModel.updateFruit(fruit: addFruit)
                                    self.presentation.wrappedValue.dismiss()
                                } else {
                                    try await adminViewModel.addFruit(fruits: addFruit)
                                }
                                adminViewModel.productImage = nil
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
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color.theme.lightGreen)

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if adminViewModel.isUpdating == false {
                        if adminViewModel.productImage == nil {
                            Button {
                                adminViewModel.showImagePicker = true
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
                        } else {
                            Image(uiImage: adminViewModel.productImage ?? UIImage(systemName: "tray.and.arrow.down")!)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.theme.gray, lineWidth: 2)
                                )
                                .cornerRadius(20)
                                .onTapGesture {
                                    adminViewModel.showImagePicker = true
                                }
                        }

                    } else {
                        AsyncImage(
                            url: URL(string: productImage),
                            transaction: Transaction(animation: .none)
                        ) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.theme.gray, lineWidth: 2)
                                    )
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        adminViewModel.showImagePicker = true
                                    }
                            case .failure:
                                Image(systemName: "wifi.slash")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 150, height: 150)
                        .padding(.bottom)
                        .onTapGesture {
                            adminViewModel.showImagePicker = true
                        }
                    }
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
                    Picker("", selection: $weightOrPieces) {
                        Text("кг").tag("кг")
                        Text("шт").tag("шт")
                    }
                    .padding(.horizontal)
                    .pickerStyle(.segmented)
                    .frame(width: 150, height: 50)
                }

                Picker("", selection: $productCategories) {
                    Text("Арбуз и дыни").tag(CategoriesFruit.all.rawValue)
                    Text("Гранат").tag(CategoriesFruit.granat.rawValue)
                    Text("Фрукты").tag(CategoriesFruit.fruct.rawValue)
                }

                .padding(.horizontal)
                .pickerStyle(.segmented)
                Spacer()
                if adminViewModel.isUpdating {

                    Button {
                        Task {
                            do {
                                try await adminViewModel.deleteFruit(id: idFruit)
                                adminViewModel.showAddFruit = false
                                self.presentation.wrappedValue.dismiss()
                                adminViewModel.selected = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    self.adminViewModel.selected = 0
                                }
                            } catch {}
                        }
                    } label: {
                        Text("Удалить")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                    }
                    .frame(width: 250, height: 40)
                    .background(Color.red)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                    .padding(.bottom, 100)
                }
            }
            .fullScreenCover(isPresented: $adminViewModel.showImagePicker) {
                ImagePicker(image: $adminViewModel.productImage, isShow: $adminViewModel.showImagePicker, sourceType: sourceType)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
