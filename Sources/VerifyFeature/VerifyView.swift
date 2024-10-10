import SwiftUI
import DesignSystem
import ComposableArchitecture

@Reducer
public struct VerifyReducer {
  public init() {}
  
  @ObservableState
  public struct State {
    var code = ""
    
    public init() {}
  }
  
  public enum Action: Sendable, ViewAction {
    case view(ViewAction)
    
    public enum ViewAction: Sendable {
      case onTapNumber(String)
      case onTapAsterisk
      case onTapHash
    }
  }
  
  public var body: some ReducerOf<VerifyReducer> {
    Reduce { state, action in
      switch action {
      case let .view(.onTapNumber(num)):
        state.code += num
        return .none
        
      case .view(.onTapAsterisk):
        if !state.code.isEmpty {
          state.code.removeLast()
        }
        return .none
        
      case .view(.onTapHash):
        return .none
      }
    }
  }
}

@ViewAction(for: VerifyReducer.self)
public struct VerifyView: View {
  @Bindable public var store: StoreOf<VerifyReducer>
  
  public init(store: StoreOf<VerifyReducer>) {
    self.store = store
  }
  
  public var body: some View {
    PocketBellInputView {
      content
    } onTapNumber: { num in
      send(.onTapNumber(num.description))
    } onTapAsterisk: {
      send(.onTapAsterisk)
    } onTapHash: {
      send(.onTapHash)
    }
  }
  
  var content: some View {
    VStack(spacing: 24) {
      Text("カクニンコードヲニュウリョク")
        .font(.title3)
        .foregroundColor(.white)
      
      Text(store.code)
        .font(.largeTitle)
        .foregroundColor(.white)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .bottomLeading) {
      Text("*デサクジョ")
    }
    .overlay(alignment: .bottomTrailing) {
      Text("#デケッテイ")
    }
    .padding(.all, 8)
  }
}

#Preview(traits: .landscapeLeft) {
  Group {
    VerifyView(
      store: .init(
        initialState: VerifyReducer.State.init(),
        reducer: { VerifyReducer() }
      )
    )
  }
  .background()
  .environment(\.colorScheme, .dark)
}
