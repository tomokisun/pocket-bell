import DependenciesMacros
import SharedModels

@DependencyClient
public struct APIClient: Sendable {
  public var globalConfig: @Sendable () async throws -> AsyncThrowingStream<GlobalConfig, Error>
  public var messages: @Sendable () async throws -> AsyncThrowingStream<[Message], Error>
}
