import Foundation

public protocol PageManagerActorProtocol: Actor {
    func getCurrentPage() async -> Int
    func getNextPage() async -> Int
    func incrementPage() async
    func reset() async
}

