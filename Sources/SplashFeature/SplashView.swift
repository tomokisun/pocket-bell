import SwiftUI
import ComposableArchitecture

@Reducer
public struct SplashReducer {
  public init() {}
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Sendable {
    
  }
}

public struct SplashView: View {
  @Bindable public var store: StoreOf<SplashReducer>
  
  public init(store: StoreOf<SplashReducer>) {
    self.store = store
  }
  
  public var body: some View {
    ProgressView()
      .tint(Color.white)
  }
}
