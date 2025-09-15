import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    var index: Int
    var centeredIndex: Int
    var zIndexAdjusted: Bool
    
    init(index: Int, centerredIndex: Int, zIndexAdjusted: Bool, @ViewBuilder content: () -> Content) {
        self.index = index
        self.centeredIndex = centerredIndex
        self.zIndexAdjusted = zIndexAdjusted
        self.content = content()
    }
    
    var body: some View {
        content
            .offset(x: offset(for: index, centeredCardIndex: centeredIndex))
            .scaleEffect(scale(for: index, centeredCardIndex: centeredIndex))
            .zIndex(zIndex(for: index, centeredCardIndex: centeredIndex))
    }
    
    private func offset(for index: Int, centeredCardIndex: Int) -> CGFloat {
        if index == centeredCardIndex {
            return 0 // Center
        } else if (centeredCardIndex + 1) % 3 == index {
            return 100 // Right
        } else {
            return -100 // Left
        }
    }
    
    private func scale(for index: Int, centeredCardIndex: Int) -> CGFloat {
        return index == centeredCardIndex ? 1.0 : 0.8
    }
    
    private func zIndex(for index: Int, centeredCardIndex: Int) -> Double {
        if (!zIndexAdjusted) {
            // The card at the center should have the highest z-index, while the cards to its left and right should share the same z-index.
            if (index == centeredCardIndex) {
                return 1
            }
            return 0
        } else {
            // The card that was previously in the center should remain at its current z-index until the z-index uppdate.
            if (index == centeredCardIndex - 1) {
                return 1
            }
            // The z-index of the card on the left should be lower than the z-index of the card on the right.
            return index == (centeredCardIndex + 1) % 3 ? -2 : -1
        }
    }
}

struct CarouselView: View {
    @State private var centeredCardIndex: Int = 0
    @State private var zIndexAdjusted: Bool = false
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            CardView(
                index: 0, centerredIndex: centeredCardIndex, zIndexAdjusted: zIndexAdjusted, content: {
                    VStack {
                        HStack(alignment: .top) {
                            Rectangle()
                                .frame(width: 20, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Spacer()
                            Rectangle()
                                .frame(width: 40, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Rectangle()
                                .frame(width: 10, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        Spacer()
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 20)
                                .clipShape(Capsule())
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 130, height: 20)
                                .clipShape(Capsule())
                                .padding(.vertical, 10)
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 50, height: 10)
                                .clipShape(Capsule())
                        }
                        HStack {
                            HStack {
                                Rectangle()
                                    .fill(Color(hue: 0.6, saturation: 1,brightness: 0.5))
                                    .frame(width: 30, height: 10)
                                    .clipShape(Capsule())
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                                    .padding(.vertical, 10)
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .stroke(.gray, lineWidth: 1)
                                )
                        }
                        .padding(.top, 25)
                    }
                    .padding()
                    .cardBorder()
                }
            )
            
            CardView(
                index: 1, centerredIndex: centeredCardIndex, zIndexAdjusted: zIndexAdjusted, content: {
                    VStack {
                        HStack(alignment: .top) {
                            Rectangle()
                                .frame(width: 20, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Spacer()
                            Rectangle()
                                .frame(width: 40, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Rectangle()
                                .frame(width: 10, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        Spacer()
                        Image("2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 20)
                                .clipShape(Capsule())
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 130, height: 20)
                                .clipShape(Capsule())
                                .padding(.vertical, 10)
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 50, height: 10)
                                .clipShape(Capsule())
                        }
                        HStack {
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                                Rectangle()
                                    .fill(Color(hue: 0.6, saturation: 1,brightness: 0.5))
                                    .frame(width: 30, height: 10)
                                    .clipShape(Capsule())
                                    .padding(.vertical, 10)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .stroke(.gray, lineWidth: 1)
                                )
                        }
                    }
                    .padding()
                    .cardBorder()
                }
            )
            CardView(
                index: 2, centerredIndex: centeredCardIndex, zIndexAdjusted: zIndexAdjusted, content: {
                    VStack {
                        HStack(alignment: .top) {
                            Rectangle()
                                .frame(width: 20, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Spacer()
                            Rectangle()
                                .frame(width: 40, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                            Rectangle()
                                .frame(width: 10, height: 5)
                                .foregroundColor(.gray.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        Spacer()
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 20)
                                .clipShape(Capsule())
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 130, height: 20)
                                .clipShape(Capsule())
                                .padding(.vertical, 10)
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 50, height: 10)
                                .clipShape(Capsule())
                        }
                        HStack {
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 10, height: 10)
                                    .clipShape(Capsule())
                                    .padding(.vertical, 10)
                                Rectangle()
                                    .fill(Color(hue: 0.6, saturation: 1,brightness: 0.5))
                                    .frame(width: 30, height: 10)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .stroke(.gray, lineWidth: 1)
                                )
                        }
                    }
                    .padding()
                    .cardBorder()
                }
            )
            
        }
        .padding()
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.7)) {
                // Update the z-index should trigger while the animation is in progress.
                self.zIndexAdjusted.toggle()
                centeredCardIndex = (centeredCardIndex + 1) % 3
            }
            // The z-index position should update once the card has moved halfway to the left.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
                self.zIndexAdjusted.toggle()
            }
        }
    }
}

struct CardBorderModifier: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .stroke(.gray, lineWidth: 2)
            )
    }
}

extension View {
    func cardBorder() -> some View {
        self.modifier(CardBorderModifier(width: 200, height: 350, color: .white, cornerRadius: 10))
    }
}

// Preview
#Preview {
    CarouselView()
}
