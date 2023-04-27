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
    @State var productFavorite = false

    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Environment(\.presentationMode) var presentation
    func countProductName() -> String {
        let counts = 20 - productName.count
        return String(counts)
    }

    func countProductDes() -> String {
        let counts = 100 - productDescription.count
        return String(counts)
    }

    func doubleChecking() -> Bool {
        let num = Double(productPrice.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil))
        if num != nil {
            return false
        } else {
            return true
        }
    }

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
                if productName.isEmpty || productPrice.isEmpty || doubleChecking() || productDescription.isEmpty || productDiscount.isEmpty || productCategories.isEmpty {} else {
                    Button {
                        adminViewModel.saveImageFirebaseStorageURL()

                        let addFruit = Fruit(id: idFruit,
                                             cost: Double(productPrice) ?? 0,
                                             weightOrPieces: weightOrPieces,
                                             categories: productCategories,
                                             favorite: productFavorite ? true : false,
                                             count: 1,
                                             image: adminViewModel.productImage == nil ? productImage : adminViewModel.urlImageString,
                                             name: productName,
                                             percent: Int(productDiscount) ?? 0,
                                             comment: productDescription,
                                             stepCount: 1)

                        Task {
                            do {
                                if adminViewModel.isUpdating {
                                    try await adminViewModel.hideFruit(fruit: addFruit)
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
            .padding(.top, 10)
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
                                    .foregroundColor(Color.theme.green4)
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
                                .frame(width: 180, height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.theme.grafit, lineWidth: 2)
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
                                    .frame(width: 180, height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.theme.grafit, lineWidth: 2)
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
                .padding(.top, 15)
                ZStack(alignment: .trailing) {
                    TextFieldView(text: $productName, placeholder: "Product name (up to 20 characters) ", infoText: "Product name")
                        .disabled(productName.count >= 20)
                    Text("\(countProductName())")
                        .foregroundColor(.red.opacity(0.5))
                        .padding(.horizontal, 25)
                }

                HStack {
                    Text("Description")
                        .padding(.leading, 30)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .opacity(productDescription.isEmpty ? 0.5 : 1)
                    Spacer()
                    Text("\(countProductDes())")
                        .foregroundColor(.red.opacity(0.5))
                        .padding(.horizontal, 25)
                }
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $productDescription)
                        .disabled(productDescription.count >= 100)
                        .lineLimit(7)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(18, .pFBeauSansProRegular)))
                        .background(.clear)
                        .padding(.leading, 20)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                        )
                        .padding()
                    if productDescription.isEmpty {
                        Text("Description (up to 100 characters)")
                            .padding(.top, 10)
                            .foregroundColor(.gray.opacity(0.5))
                            .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                            .padding(.leading, 20)
                            .padding()
                    }
                }
                .offset(y: -20)

                TextFieldView(text: $productPrice, placeholder: "Price, $ ", infoText: "Price")
                    .keyboardType(.decimalPad)
                    .offset(y: -20)
                HStack {
                    TextFieldView(text: $productDiscount, placeholder: "Discount", infoText: "Discount")
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 150)
                    Text("%")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                    Spacer()
                    Picker("Unit", selection: $weightOrPieces) {
                        Text("lbs").tag("кг")
                        Text("pcs").tag("шт")
                    }
                    .padding(.horizontal)
                    .pickerStyle(.segmented)
                    .frame(width: 150, height: 50)
                }
                .offset(y: -20)

                Picker("Category", selection: $productCategories) {
                    Text("Watermelon and melon").tag(CategoriesFruit.all.rawValue)
                    Text("Garnet").tag(CategoriesFruit.granat.rawValue)
                    Text("Fruit").tag(CategoriesFruit.fruct.rawValue)
                }
                .offset(y: -20)
                .padding(.horizontal)
                .pickerStyle(.segmented)
                Spacer()
                if adminViewModel.isUpdating {

                    Button {
//                        adminViewModel.saveImageFirebaseStorageURL()

                        let hideFruit = Fruit(id: idFruit,
                                              cost: Double(productPrice) ?? 1,
                                              weightOrPieces: weightOrPieces,
                                              categories: productCategories,
                                              favorite: productFavorite ? false : true,
                                              count: 1,
                                              image: productImage,
                                              name: productName,
                                              percent: Int(productDiscount) ?? 0,
                                              comment: productDescription,
                                              stepCount: 1)
                        Task {

                            do {
                                try await adminViewModel.hideFruit(fruit: hideFruit)
                                adminViewModel.showAddFruit = false
                                adminViewModel.isUpdating = false
                                adminViewModel.selected = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    self.adminViewModel.selected = 0
                                }

                                self.presentation.wrappedValue.dismiss()
                            } catch {}
                        }
                    } label: {
                        Text(productFavorite ? "Show" : "Hide")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                    }
                    .frame(width: 250, height: 40)
                    .background(Color.red)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                    .padding(.bottom, 80)
                }
            }
            .fullScreenCover(isPresented: $adminViewModel.showImagePicker) {
                ImagePicker(image: $adminViewModel.productImage, isShow: $adminViewModel.showImagePicker, sourceType: sourceType)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
