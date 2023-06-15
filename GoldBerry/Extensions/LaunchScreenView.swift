import SwiftUI

enum Constantss {
    enum Circle {
        enum Radius {
            static let scaled: CGFloat = 500
            static let basic: CGFloat = 25
        }

        enum Offset {
            static let offseted: CGFloat = 70
            static let basic: CGFloat = 0
        }
    }
}

struct LaunchScreenView: View {

    @State var changeMode = false
    @State var scaled = true
    @State var circleOffseted = true
    @State var rotate = false
    @State var stripesVisible = false
    @State var stripesOffseted = true
    @State var textRectVisible = false
    @State var textVisible = false
    @State var textOffseted = true
    @State var isFinished = true

    var body: some View {
        ZStack {
            Image("Дизайн без названия-3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .zIndex(0)
                
//            Color.theme.orange.zIndex(0)
            Color.black.opacity(0.3)


            ZStack(alignment: .center) {
                ZStack(alignment: .top) {
                    Circle()
                        .fill(.clear)
                        .frame(width: 280)
                        .zIndex(1)

//                    Image("goldBerryLogo")
                    Text("OK_fruit")
                        .font(Font(uiFont: .fontLibrary(45, .pFBeauSansProSemiBold)))
                        .kerning(0)
                        .foregroundColor(.white)

//                        .resizable()
                        .aspectRatio(contentMode: changeMode ? .fit : .fill)
                        .frame(width: scaled ? Constantss.Circle.Radius.scaled * 2 : Constantss.Circle.Radius.basic / 0.14)
                        .offset(y: circleOffseted ? Constantss.Circle.Offset.basic : Constantss.Circle.Offset.offseted)
                        .zIndex(2)
                        .onTapGesture {}
                }
                .rotationEffect(.degrees(rotate ? 360 : 0))

                HStack(spacing: 0) {}
                    .opacity(stripesVisible ? 1 : 0)

                VStack(spacing: 0) {
                    Text("Доставка фруктов \nпо Минску и району")
                        .kerning(0)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(Font(uiFont: .fontLibrary(32, .pFBeauSansProSemiBold)))
                        .offset(y: textOffseted ? 20 : 0)
                        .opacity(textVisible ? 1 : 0)
                }
                .fixedSize()
                .offset(y: 100)
                .opacity(textRectVisible ? 1 : 0)
            }
            .zIndex(1)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            guard isFinished else { return }
            isFinished = false
            changeMode.toggle()

            withAnimation(.linear(duration: 0.5)) {
                scaled.toggle()
            }
            withAnimation(.linear(duration: 1.0).delay(0.5)) {
                rotate.toggle()
            }
            withAnimation(.spring(response: 0.6,
                                  dampingFraction: 0.4,
                                  blendDuration: 0).delay(1.5)) {
                circleOffseted.toggle()
            }
            withAnimation(.linear(duration: 0.2).delay(1.5)) {

                textRectVisible.toggle()
            }
            withAnimation(.linear(duration: 0.2).delay(1.7)) {
                stripesVisible.toggle()
            }
            withAnimation(.spring(response: 0.35,
                                  dampingFraction: 0.25,
                                  blendDuration: 0).delay(1.8)) {
                stripesOffseted.toggle()
            }
            withAnimation(.linear(duration: 0.2).delay(2.3)) {
                textVisible.toggle()
            }
            withAnimation(.linear(duration: 0.4).delay(2.4)) {
                textOffseted.toggle()
            }
        }
    }
}

struct Stripe: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.maxX, y: 0))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY - rect.width / 2))
        path.addQuadCurve(to: .init(x: rect.midX, y: rect.maxY), control: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.width / 2, y: rect.width / 2))
        path.addQuadCurve(to: .init(x: rect.maxX, y: 0), control: .init(x: rect.midX, y: 0))
        return path
    }
}

struct Logo: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Image("goldBerryLogo")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}
