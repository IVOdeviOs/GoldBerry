import SwiftUI

struct OrderAdminView: View {
    @ObservedObject var adminViewModel: AdminViewModel
    @State var orderCompleted = false
    var body: some View {

        VStack {
            HStack {
                Picker("", selection: $orderCompleted) {
                    Text("На рассмотрение").tag(false)
                    Text("Выполнены").tag(true)
                }
                .pickerStyle(.segmented)
            }
            .padding()
            List(adminViewModel.order) { item in
                if item.orderCompleted == orderCompleted {
                    NavigationLink {
                        OrderInfoAdminView(order: item,adminViewModel: adminViewModel)
                    } label: {
                        OrderAdminCell(date: item.date,
                                       dateOrder: item.dateOrder,
                                       numberOrder: item.orderNumber,
                                       price: item.price,
                                       address: item.address,
                                       order: item.customer,
                                       phoneNumber: item.customerPhone,
                                       count: String(item.fruits.count))
                    }
                }
            }

            .padding(.bottom, 140)
            .accessibilityElement()
            .navigationViewStyle(.columns)
            .listStyle(.plain)
            .navigationBarHidden(true)
        }
    }
}
