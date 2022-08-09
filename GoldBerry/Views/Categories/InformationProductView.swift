import SwiftUI

struct InformationProductView: View {
    var body: some View {

        VStack {
            ZStack(alignment: .top) {
                Image("fresh")
                    .resizable()
                    .frame(height: 350)
                    .aspectRatio(contentMode: .fit)
                HStack {
                    Button {
                        //
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
                .padding(.top, 36)
            }
            Spacer()

        }.ignoresSafeArea()
    }
}

struct InformationProductView_Previews: PreviewProvider {
    static var previews: some View {
        InformationProductView()
    }
}
