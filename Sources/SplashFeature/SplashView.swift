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
  public var body: some View {
    ProgressView()
      .tint(Color.white)
  }
}
