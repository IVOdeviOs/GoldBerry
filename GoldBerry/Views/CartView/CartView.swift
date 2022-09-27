import CoreData
import SwiftUI

struct CartView: View {
    @StateObject var viewModel = FruitViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        if self.fruits.isEmpty {
            WithoutPurchase(viewModel: viewModel)
        } else {
            WithPurchase(viewModel: viewModel)
        }
    }
}

struct WithoutPurchase: View {
    @StateObject var viewModel: FruitViewModel

    var body: some View {
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("В корзине пока пусто")
                .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            Text("Ваша корзина ждет, пока ее наполнят!")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            Button {
                viewModel.selected = 0
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithPurchase: View {
    @ObservedObject var viewModel: FruitViewModel
//    @ObservedObject var reg = FireBaseLogin()
    @State var show = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.image, ascending: true)])

    var fruits: FetchedResults<FruitEntity>

    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])

    var user: FetchedResults<UserRegEntity>

    
    var body: some View {
        ZStack(alignment: .top) {
           
            ScrollView(showsIndicators: false) {

                ForEach(viewModel.fruit) { item in
                    ForEach(fruits) { i in
                        if i.id == item.id {
                            CartCell(
                                viewModel: viewModel,
                                imageName: item.image,
                                cost: item.itog,
                                name: item.name,
                                index: item.name,
                                description: item.descriptions ?? "",
                                count: Int(item.count),
                                price: Double(item.cost)
                            )
                        }
                    }

                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                }

                .padding(.top, 125)
                .padding(.bottom, 100)
          
                .ignoresSafeArea()
            }
            ZStack {
                VStack {

                    Spacer()

                    Button {
                            self.show.toggle()
                    } label: {
                        Text("Оформить заказ   \(NSString(format: "%.2f", viewModel.price)) р")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color.theme.lightGreen)
                            .cornerRadius(10)
                            .padding(.bottom, 150)
                    }
                    .offset(y: 115)
                    .sheet(isPresented: $show, content: {
                        MakingTheOrderView(viewModel: viewModel)
                    })

                }
            }
           

            .navigationBarHidden(true)
        }
        .offset(y: -95)
       
    }


}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: FruitViewModel())
    }
}
