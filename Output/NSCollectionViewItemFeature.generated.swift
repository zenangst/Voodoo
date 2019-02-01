// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cocoa


class EditorialMacOSViewController: NSViewController {
  private let layout: NSCollectionViewFlowLayout
  private let collectionView: NSCollectionView
  private let dataSource = EditorialMacOSDataSource()

  init(layout: NSCollectionViewFlowLayout, collectionView: NSCollectionView?) {
    self.layout = layout
    if let collectionView = collectionView {
      self.collectionView = collectionView
    } else {
      self.collectionView = NSCollectionView()
    }
    self.collectionView.collectionViewLayout = layout
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func loadView() {
    self.view = collectionView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = dataSource
    let identifier = NSUserInterfaceItemIdentifier.init("EditorialMacOSView")
    collectionView.register(EditorialMacOSView.self, forItemWithIdentifier: identifier)
  }

  // MARK: - Public API

  func reload(with models: [EditorialMacOSViewModel]) {
    dataSource.reload(collectionView, with: models)
  }
}

class EditorialMacOSDataSource: NSObject, NSCollectionViewDataSource {

  private var models = [EditorialMacOSViewModel]()

  init(models: [EditorialMacOSViewModel] = []) {
    self.models = models
    super.init()
  }

  // MARK: - Public API

  func model(at indexPath: IndexPath) -> EditorialMacOSViewModel {
    return models[indexPath.item]
  }

  func reload(_ collectionView: NSCollectionView,
              with models: [EditorialMacOSViewModel]) {
    self.models = models
    collectionView.reloadData()
  }

  // MARK: - NSCollectionViewDataSource

  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }

  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let identifier = NSUserInterfaceItemIdentifier.init("EditorialMacOSView")
    let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)
    let model = self.model(at: indexPath)

    if let view = item as? EditorialMacOSView {
      view.customImageView.image = model.image
      view.titleLabel.stringValue = model.title
      view.subtitleLabel.stringValue = model.subtitle
    }

    return item
  }
}

struct EditorialMacOSViewModel: Hashable {
  let image: NSImage
  let title: String
  let subtitle: String
}
