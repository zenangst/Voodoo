// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

protocol EditorialErrorViewController : class {
  var error: Error { set get }
}

enum EditorialViewState {
  case initial
  case loading
  case failure(error: Error)
  case success(models: [EditorialViewModel])
}

class EditorialViewStateController: UIViewController {
  typealias ErrorViewControllerType = EditorialErrorViewController & UIViewController

  private let initialViewController: UIViewController
  private let loadingViewController: UIViewController
  private let failureViewController: ErrorViewControllerType
  private let successController: EditorialViewController

  public init(initialViewController: UIViewController,
       loadingViewController: UIViewController,
       failureViewController: ErrorViewControllerType,
       successController: EditorialViewController) {
    self.initialViewController = initialViewController
    self.loadingViewController = loadingViewController
    self.failureViewController = failureViewController
    self.successController = successController
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render(_ state: EditorialViewState) {
    children.forEach {
      $0.removeFromParent()
    }
    let viewController: UIViewController
    switch state {
    case .initial:
      viewController = initialViewController
    case .loading:
      viewController = loadingViewController
    case .failure(let error):
      viewController = failureViewController
      failureViewController.error = error
    case .success(let models):
      viewController = successController
      successController.reload(with: models)
    }
    viewController.willMove(toParent: self)
    addChild(viewController)
    viewController.view.frame = view.bounds
    view.addSubview(viewController.view)
    viewController.didMove(toParent: self)
  }
}
