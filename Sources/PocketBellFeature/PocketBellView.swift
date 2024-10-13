import SwiftUI
import DesignSystem
import TwoTouchParser
import ComposableArchitecture

@Reducer
public struct PocketBellReducer {
  public init() {}
  
  @ObservableState
  public struct State: Equatable {
    var selection: Int = 0
    var messages: [String] = [
      "5152324493674010372341043112",
      "1112324493",
      "15432194317168",
      "11324111149367",
      "3323042114927133"
    ]

    public init() {}
  }
  
  public enum Action: Sendable, ViewAction {
    case view(ViewAction)
    
    public enum ViewAction: Sendable {
      case onTask
      case onTapLeft
      case onTapRight
    }
  }
  
  public var body: some ReducerOf<PocketBellReducer> {
    Reduce { state, action in
      switch action {
      case .view(.onTask):
        return .none
        
      case .view(.onTapLeft):
        state.selection -= 1
        return .none
        
      case .view(.onTapRight):
        state.selection += 1
        return .none
      }
    }
  }
}

@ViewAction(for: PocketBellReducer.self)
public struct PocketBellView: View {
  @Bindable public var store: StoreOf<PocketBellReducer>
  
  public init(store: StoreOf<PocketBellReducer>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
      
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.gray)
        .overlay(
          VStack(spacing: 20) {
            ZStack {
              RoundedRectangle(cornerRadius: 16)
                .fill(Color.black)
                .shadow(color: .black.opacity(0.6), radius: 8, x: -3, y: -3)
              
              Text("POKE BELL")
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.all, 4)
              
              VStack(spacing: 0) {
                Text(try! TwoTouchDecoder().decode(from: store.messages[store.selection]))
                  .font(.system(size: 100, weight: .black, design: .monospaced))
                  .minimumScaleFactor(0.01)
                  .foregroundStyle(Color.black)
                  .frame(maxWidth: .infinity, maxHeight: .infinity)

                Text(Date.now, format: Date.FormatStyle.dateTime)
                  .font(.system(.footnote, design: .monospaced, weight: .bold))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundStyle(Color.white)
                  .padding(.all, 8)
              }
              .background(Color.green.opacity(0.7))
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .padding(.all, 26)
            }
            
            // ボタン部分
            HStack(spacing: 30) {
              Button {
                send(.onTapLeft, animation: .default)
              } label: {
                Image(systemName: "arrowtriangle.left.fill")
                  .font(.system(size: 40))
                  .foregroundStyle(Color.white)
                  .frame(height: 80)
                  .padding(.leading, 65)
                  .padding(.trailing, 55)
                  .background(Capsule().fill(Color.black))
                  .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
              }
              
              Spacer()
              
              Button {
                
              } label: {
                Image(systemName: "arrowtriangle.right.fill")
                  .font(.system(size: 40))
                  .foregroundStyle(Color.white)
                  .frame(width: 80, height: 80)
                  .background(Capsule().fill(Color.black))
                  .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
              }
              
              Spacer()
              
              Button {
                send(.onTapRight, animation: .default)
              } label: {
                Image(systemName: "arrowtriangle.right.fill")
                  .font(.system(size: 40))
                  .foregroundStyle(Color.white)
                  .frame(height: 80)
                  .padding(.leading, 55)
                  .padding(.trailing, 65)
                  .background(Capsule().fill(Color.black))
                  .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
              }
            }
            .padding(.horizontal, 60)
            .buttonStyle(HoldDownButtonStyle())
          }
          .padding()
        )
    }
  }
}

#Preview(traits: .landscapeLeft) {
  PocketBellView(
    store: .init(
      initialState: PocketBellReducer.State(),
      reducer: { PocketBellReducer() }
    )
  )
}
