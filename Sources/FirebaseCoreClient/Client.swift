import DependenciesMacros

@DependencyClient
public struct FirebaseCoreClient: Sendable {
  public var configure: @Sendable () -> Void
}
