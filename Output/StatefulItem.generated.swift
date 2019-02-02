// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cocoa

protocol EditorialItemErrorViewController : class {
  var error: Error { set get }
}

enum EditorialItemState {
  case initial
  case loading
  case failure(error: Error)
  case success(models: [EditorialItemModel])
}

class EditorialItemStateController: NSViewController {
  typealias ErrorViewControllerType = EditorialItemErrorViewController & NSViewController

  private let initialViewController: NSViewController
  private let loadingViewController: NSViewController
  private let failureViewController: ErrorViewControllerType
  private let successController: EditorialItemViewController

  public init(initialViewController: NSViewController,
       loadingViewController: NSViewController,
       failureViewController: ErrorViewControllerType,
       successController: EditorialItemViewController) {
    self.initialViewController = initialViewController
    self.loadingViewController = loadingViewController
    self.failureViewController = failureViewController
    self.successController = successController
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render(_ state: EditorialItemState) {
    children.forEach {
      $0.removeFromParent()
    }
    let viewController: NSViewController
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
    addChild(viewController)
    viewController.view.frame = view.bounds
    view.addSubview(viewController.view)
  }
}

