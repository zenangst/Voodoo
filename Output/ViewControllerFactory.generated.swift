// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

class ViewControllerFactory {
  public func createEditorialTableViewStateController(initialViewController: UIViewController = .init(),
                                          loadingViewController: UIViewController = .init(),
                                          failureViewController: EditorialTableViewCellStateController.ErrorViewControllerType) -> EditorialTableViewCellStateController {
    let viewController = createEditorialTableViewController()
    let stateController = EditorialTableViewCellStateController(
      initialViewController: initialViewController,
      loadingViewController: loadingViewController,
      failureViewController: failureViewController,
      successController: viewController
    )

    return stateController
  }
  public func createEditorialTableViewController() -> EditorialTableViewController {
    let viewController = EditorialTableViewController()
    return viewController
  }
  public func createEditorialViewStateController(layout: UICollectionViewFlowLayout,
                                          initialViewController: UIViewController = .init(),
                                          loadingViewController: UIViewController = .init(),
                                          failureViewController: EditorialViewStateController.ErrorViewControllerType) -> EditorialViewStateController {
    let viewController = createEditorialViewController(layout: layout)
    let stateController = EditorialViewStateController(
      initialViewController: initialViewController,
      loadingViewController: loadingViewController,
      failureViewController: failureViewController,
      successController: viewController
    )

    return stateController
  }

  public func createEditorialViewController(layout: UICollectionViewFlowLayout) -> EditorialViewController {
    let viewController = EditorialViewController(layout: layout)
    return viewController
  }
}
