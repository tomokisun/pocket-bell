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
    }
  )
}
