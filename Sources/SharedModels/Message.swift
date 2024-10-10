import Foundation

public struct Message: Codable {
  public let text: String
  public let phoneNumberHash: String
  public let createdAt: Date
  
  public init(
    text: String,
    phoneNumberHash: String,
    createdAt: Date
  ) {
    self.text = text
    self.phoneNumberHash = phoneNumberHash
    self.createdAt = createdAt
  }
}
