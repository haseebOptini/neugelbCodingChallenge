import SwiftUI

@main
struct NeugelbCodingChallengeApp: App {
    @StateObject private var coordinator: Coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(self.coordinator)
        }
    }
}
