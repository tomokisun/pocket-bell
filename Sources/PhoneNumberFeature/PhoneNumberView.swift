import SwiftUI
import DesignSystem
import ComposableArchitecture

@Reducer
public struct PhoneNumberReducer {
  public init() {}
  
  @ObservableState
  public struct State: Equatable {
    var phoneNumber = ""

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
  
  public var body: some ReducerOf<PhoneNumberReducer> {
    Reduce { state, action in
      switch action {
      case let .view(.onTapNumber(num)):
        state.phoneNumber += num
        return .none
        
      case .view(.onTapAsterisk):
        if !state.phoneNumber.isEmpty {
          state.phoneNumber.removeLast()
        }
        return .none
        
      case .view(.onTapHash):
        return .none
      }
    }
  }
}

@ViewAction(for: PhoneNumberReducer.self)
public struct PhoneNumberView: View {
  @Bindable public var store: StoreOf<PhoneNumberReducer>
  
  public init(store: StoreOf<PhoneNumberReducer>) {
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
      Text("PHONE NUMBERヲニュウリョクシテクダサイ")
        .font(.title3)
        .foregroundColor(.white)

      Text(store.phoneNumber)
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
    PhoneNumberView(
      store: .init(
        initialState: PhoneNumberReducer.State(),
        reducer: { PhoneNumberReducer() }
      )
    )
  }
  .background()
  .environment(\.colorScheme, .dark)
}
