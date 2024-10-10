import ComposableArchitecture
import SwiftUI
import PhoneNumberFeature
import PocketBellFeature
import SendFeature
import VerifyFeature
import SharedModels
import APIClient

@Reducer
public struct AppReducer: Sendable {
  public init() {}
  
  @ObservableState
  public enum State {
    case splash
    case phoneNumber(PhoneNumberReducer.State)
    case pocketBell(PocketBellReducer.State)
    case verify(VerifyReducer.State)
  }
  
  public enum Action: Sendable, ViewAction {
    case phoneNumber(PhoneNumberReducer.Action)
    case pocketBell(PocketBellReducer.Action)
    case verify(VerifyReducer.Action)
    case globalConfigRespnse(Result<GlobalConfig, any Error>)
    case view(View)

    @CasePathable
    public enum View: Sendable {
      case onTask
    }
  }
  
  @Dependency(APIClient.self) var api
  
  public var body: some ReducerOf<AppReducer> {
    Reduce { state, action in
      switch action {
      case .view(.onTask):
        state = .phoneNumber(.init())
        return .none

      case .phoneNumber(.view(.onTapHash)):
        state = .verify(.init())
        return .none

      case .verify(.view(.onTapHash)):
        state = .pocketBell(.init())
        return .none

      case let .globalConfigRespnse(.success(config)):
        print(config)
        return .none
        
      case let .globalConfigRespnse(.failure(error)):
        print(error)
        return .none

      default:
        return .none
      }
    }
    .ifCaseLet(\.phoneNumber, action: \.phoneNumber) {
      PhoneNumberReducer()
    }
    .ifCaseLet(\.pocketBell, action: \.pocketBell) {
      PocketBellReducer()
    }
    .ifCaseLet(\.verify, action: \.verify) {
      VerifyReducer()
    }
  }
}

@ViewAction(for: AppReducer.self)
public struct AppView: View {
  @Bindable public var store: StoreOf<AppReducer>
  
  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }
  
  public var body: some View {
    Group {
      switch store.state {
      case .splash:
        ProgressView()

      case .phoneNumber:
        if let store = store.scope(state: \.phoneNumber, action: \.phoneNumber) {
          PhoneNumberView(store: store)
        }

      case .pocketBell:
        if let store = store.scope(state: \.pocketBell, action: \.pocketBell) {
          PocketBellView(store: store)
        }

      case .verify:
        if let store = store.scope(state: \.verify, action: \.verify) {
          VerifyView(store: store)
        }
      }
    }
    .task { await send(.onTask).finish() }
  }
}
