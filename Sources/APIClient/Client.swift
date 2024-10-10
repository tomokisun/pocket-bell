import DependenciesMacros
import SharedModels

@DependencyClient
public struct APIClient: Sendable {
  public var globalConfig: @Sendable () async throws -> AsyncThrowingStream<GlobalConfig, Error>
  
  public var messages: @Sendable (_ phoneNumberHash: String) async throws -> AsyncThrowingStream<[Message], Error>
  public var createMessage: @Sendable (_ message: Message) async throws -> Void
}
