import AppFeature
import SplashFeature
import ComposableArchitecture
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: AppReducer.State(),
    reducer: {
      AppReducer()
        ._printChanges()
    }
  )

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    store.send(.appDelegate(.didFinishLaunching))
    return true
  }
}

@main
struct PocketBellApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
    }
  }
}
