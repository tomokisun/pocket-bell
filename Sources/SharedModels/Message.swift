import Foundation

public struct Message: Codable {
  public let message: String
  public let phoneNumberHash: String
  public let createdAt: Date
  
  public init(
    message: String,
    phoneNumberHash: String,
    createdAt: Date
  ) {
    self.message = message
    self.phoneNumberHash = phoneNumberHash
    self.createdAt = createdAt
  }
}
