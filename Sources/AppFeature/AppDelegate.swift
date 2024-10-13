import ComposableArchitecture
import FirebaseCoreClient
import UIKit

@Reducer
public struct AppDelegateReducer {
  @ObservableState
  public struct State: Equatable {}

  public enum Action: Sendable {
    case didFinishLaunching
  }

  @Dependency(FirebaseCoreClient.self) var firebaseCore

  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didFinishLaunching:
      firebaseCore.configure()
      return .none
    }
  }
}
