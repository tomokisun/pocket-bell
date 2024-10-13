import ComposableArchitecture
import SwiftUI
import PhoneNumberFeature
import PocketBellFeature
import SendFeature
import VerifyFeature
import SharedModels
import APIClient
import SplashFeature

@Reducer
public struct AppReducer: Sendable {
  public init() {}
  
  @Reducer(state: .equatable, action: .sendable)
  public enum Child {
    case splash(SplashReducer)
    case phoneNumber(PhoneNumberReducer)
    case pocketBell(PocketBellReducer)
    case verify(VerifyReducer)
  }
  
  @ObservableState
  public struct State: Equatable {
    public var child: Child.State = .splash(SplashReducer.State())
    public var appDelegate = AppDelegateReducer.State()

    public init() {}
  }
  
  public enum Action: Sendable {
    case child(Child.Action)
    case appDelegate(AppDelegateReducer.Action)
    case globalConfigRespnse(Result<GlobalConfig, any Error>)
  }
  
  @Dependency(APIClient.self) var api
  
  public var body: some ReducerOf<AppReducer> {
    Scope(state: \.child, action: \.child) {
      Child.body
    }
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateReducer()
    }
    Reduce { state, action in
      switch action {
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
  }
}

public struct AppView: View {
  @Bindable public var store: StoreOf<AppReducer>
  
  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }
  
  public var body: some View {
    Group {
      switch store.scope(state: \.child, action: \.child).state {
      case .splash:
        if let store = store.scope(state: \.child.splash, action: \.child.splash) {
          SplashView(store: store)
        }

      case .phoneNumber:
        if let store = store.scope(state: \.child.phoneNumber, action: \.child.phoneNumber) {
          PhoneNumberView(store: store)
        }

      case .pocketBell:
        if let store = store.scope(state: \.child.pocketBell, action: \.child.pocketBell) {
          PocketBellView(store: store)
        }

      case .verify:
        if let store = store.scope(state: \.child.verify, action: \.child.verify) {
          VerifyView(store: store)
        }
      }
    }
  }
}
