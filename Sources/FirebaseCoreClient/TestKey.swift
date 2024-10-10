import Dependencies

extension FirebaseCoreClient: TestDependencyKey {
  public static let testValue = Self()
}
