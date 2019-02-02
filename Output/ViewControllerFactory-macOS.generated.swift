// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cocoa

class ViewControllerFactory {
  public func createEditorialItemStateController(layout: NSCollectionViewFlowLayout,
                                          initialViewController: NSViewController = .init(),
                                          loadingViewController: NSViewController = .init(),
                                          failureViewController: EditorialItemStateController.ErrorViewControllerType) -> EditorialItemStateController {
    let viewController = createEditorialItemViewController(layout: layout)
    let stateController = EditorialItemStateController(
      initialViewController: initialViewController,
      loadingViewController: loadingViewController,
      failureViewController: failureViewController,
      successController: viewController
    )

    return stateController
  }

  public func createEditorialItemViewController(layout: NSCollectionViewFlowLayout) -> EditorialItemViewController {
    let viewController = EditorialItemViewController(layout: layout)
    return viewController
  }
}

