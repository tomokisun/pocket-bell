import APIClient
import Dependencies
import SharedModels
import FirebaseFirestore

extension APIClient: DependencyKey {
  public static let liveValue = Self(
    globalConfig: {
      AsyncThrowingStream { continuation in
        let listener = Firestore.firestore()
          .document("/config/global")
          .addSnapshotListener { documentSnapshot, error in
            if let error {
              continuation.finish(throwing: error)
            }
            if let documentSnapshot {
              do {
                try continuation.yield(
                  documentSnapshot.data(as: GlobalConfig.self)
                )
              } catch {
                continuation.finish(throwing: error)
              }
            }
          }
      }
    },
    messages: { phoneNumberHash in
      AsyncThrowingStream { continuation in
        let listener = Firestore.firestore()
          .collection("/messages")
          .whereField("phoneNumberHash", isEqualTo: phoneNumberHash)
          .order(by: "createdAt", descending: true)
          .limit(to: 20)
          .addSnapshotListener { snapshot, error in
            if let error {
              continuation.finish(throwing: error)
            }
            if let snapshot {
              do {
                let documents = try snapshot.documents.map { try $0.data(as: Message.self) }
                continuation.yield(documents)
              } catch {
                continuation.finish(throwing: error)
              }
            }
          }
      }
    },
    createMessage: { message in
      try await Firestore.firestore()
        .collection("/messages")
        .addDocument(data: [
          "text": message.text,
          "phoneNumberHash": message.phoneNumberHash,
          "createdAt": message.createdAt
        ])
    }
  )
}
