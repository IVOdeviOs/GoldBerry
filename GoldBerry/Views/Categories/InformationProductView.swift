import SwiftUI

struct InformationProductView: View {
    @ObservedObject var viewModel = TabBarViewModel()
    @Environment(\.presentationMode) var presentationMode

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    var body: some View {

        ZStack(alignment: .top) {

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack(alignment: .top) {
                        Image("fresh")
                            .resizable()
                            .frame(height: 350)
                            .aspectRatio(contentMode: .fit)
                    }
                    .cornerRadius(30)
                    .padding(3)
                    Spacer()
                }
                .offset(y: -20)
                .navigationBarHidden(true)
            }

            ZStack {
                HStack {
                    Button {
                        dismiss()

                    } label: {
                        Image(systemName: "arrow.backward.square")
                            .renderingMode(.original)
                            .scaleEffect(3)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(.gray.opacity(0.8))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart")
                            .renderingMode(.template)
                            .scaleEffect(3)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(.gray.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
//                .padding(.top, 1)
            }
        }
    }
}

struct InformationProductView_Previews: PreviewProvider {
    static var previews: some View {
        InformationProductView()
    }
}
