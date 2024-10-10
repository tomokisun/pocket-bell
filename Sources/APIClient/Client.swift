import DependenciesMacros
import SharedModels

@DependencyClient
public struct APIClient: Sendable {
  public var globalConfig: @Sendable () async throws -> AsyncThrowingStream<GlobalConfig, Error>
}
