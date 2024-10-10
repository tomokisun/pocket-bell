import SwiftUI

public struct PocketBellInputView<Content: View>: View {
  let content: () -> Content
  let onTapNumber: (String) -> Void
  let onTapAsterisk: () -> Void
  let onTapHash: () -> Void
  
  public init(
    content: @escaping () -> Content,
    onTapNumber: @escaping (String) -> Void,
    onTapAsterisk: @escaping () -> Void,
    onTapHash: @escaping () -> Void
  ) {
    self.content = content
    self.onTapNumber = onTapNumber
    self.onTapAsterisk = onTapAsterisk
    self.onTapHash = onTapHash
  }
  
  public var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(Color.green.opacity(0.7))
      .overlay {
        HStack(spacing: 0) {
          ZStack {
            RoundedRectangle(cornerRadius: 16)
              .fill(Color.black)
              .shadow(color: .black.opacity(0.6), radius: 8, x: -3, y: -3)
            
            Group {
              content()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.all, 8)
          }
          .padding()
          
          LazyVGrid(
            columns: Array(repeating: GridItem(spacing: 8, alignment: .center), count: 3),
            alignment: .center,
            spacing: 8
          ) {
            ForEach(1..<10) { num in
              Button {
                onTapNumber(num.description)
              } label: {
                Text(num.description)
                  .font(.system(.largeTitle, design: .monospaced, weight: .bold))
                  .frame(width: 80, height: 80)
                  .foregroundStyle(Color.black)
                  .background(
                    Circle()
                      .fill(Color.white)
                      .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
                  )
              }
              .id(num)
            }
            
            ForEach(["*", "0", "#"], id: \.self) { item in
              Button {
                if item == "#" {
                  onTapHash()
                } else if item == "*" {
                  onTapAsterisk()
                } else if item == "0" {
                  onTapNumber(item)
                }
              } label: {
                Text(item)
                  .font(.system(.largeTitle, design: .monospaced, weight: .bold))
                  .frame(width: 80, height: 80)
                  .foregroundStyle(Color.black)
                  .background(
                    Circle()
                      .fill(Color.white)
                      .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
                  )
              }
              .id(item)
            }
          }
          .buttonStyle(HoldDownButtonStyle())
        }
      }
  }
}

#Preview(traits: .landscapeLeft) {
  Group {
    PocketBellInputView {
      Text("hoge")
    } onTapNumber: { num in
      print(num)
    } onTapAsterisk: {
      print("asterisk")
    } onTapHash: {
      print("hash")
    }
  }
  .background()
  .environment(\.colorScheme, .dark)
}
