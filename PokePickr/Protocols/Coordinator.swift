import Foundation

// MARK: - Coordinator

protocol Coordinator: AnyObject {

  var identifier: String { get }
  var children: [String: Coordinator] { get set }

  func start()
  func start(coordinator: Coordinator)
  func remove(coordinator: Coordinator)
}

// MARK: - CoordinatorCleanable

protocol CoordinatorCleanable: Coordinator {
  func cleanup()
}

// MARK: - CoordinatorAutoCleanable

protocol CoordinatorAutoCleanable: CoordinatorCleanable {}

extension CoordinatorAutoCleanable {
  func cleanup() {
    children.forEach {
      remove(coordinator: $1)
    }
  }
}

extension Coordinator {

  var identifier: String {
    return String(describing: self)
  }

  func start(coordinator: Coordinator) {
    add(child: coordinator)
    coordinator.start()
  }

  func remove(coordinator: Coordinator) {
    (coordinator as? CoordinatorCleanable)?.cleanup()
    children.removeValue(forKey: coordinator.identifier)
  }

  private func add(child: Coordinator) {
    children[child.identifier] = child
  }

}

