import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    Button {
                        selected = 0
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }.foregroundColor(selected == 0 ? .black : .gray)
                    Spacer(minLength: 12)
                    Button {
                        selected = 1
                    } label: {
                        Image(systemName: "video")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }.foregroundColor(selected == 1 ? .black : .gray)
                    Spacer()

                    Button {
                        selected = 2
                    } label: {
                        Image(systemName: "cloud")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }.foregroundColor(selected == 2 ? .black : .gray)
                    Spacer(minLength: 12)

                    Button {
                        selected = 3
                    } label: {
                        Image(systemName: "airtag")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }.foregroundColor(selected == 3 ? .black : .gray)
                }
                .padding()
                .padding(.horizontal, 22)
                .background(.green)
            }
        }
        .background(.red)
        .edgesIgnoringSafeArea(.top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
