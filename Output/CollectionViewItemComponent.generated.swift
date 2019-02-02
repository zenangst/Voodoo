// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cocoa

class EditorialItemViewController: NSViewController {
  private let layout: NSCollectionViewFlowLayout
  private let collectionView: NSCollectionView
  private let dataSource = EditorialItemDataSource()

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
    let identifier = NSUserInterfaceItemIdentifier.init("EditorialItem")
    collectionView.register(EditorialItem.self, forItemWithIdentifier: identifier)
  }

  // MARK: - Public API

  func reload(with models: [EditorialItemModel]) {
    dataSource.reload(collectionView, with: models)
  }
}

class EditorialItemDataSource: NSObject, NSCollectionViewDataSource {

  private var models = [EditorialItemModel]()

  init(models: [EditorialItemModel] = []) {
    self.models = models
    super.init()
  }

  // MARK: - Public API

  func model(at indexPath: IndexPath) -> EditorialItemModel {
    return models[indexPath.item]
  }

  func reload(_ collectionView: NSCollectionView,
              with models: [EditorialItemModel]) {
    self.models = models
    collectionView.reloadData()
  }

  // MARK: - NSCollectionViewDataSource

  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }

  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let identifier = NSUserInterfaceItemIdentifier.init("EditorialItem")
    let item = collectionView.makeItem(withIdentifier: identifier, for: indexPath)
    let model = self.model(at: indexPath)

    if let view = item as? EditorialItem {
      view.customImageView.image = model.image
      view.titleLabel.stringValue = model.title
      view.subtitleLabel.stringValue = model.subtitle
    }

    return item
  }
}

struct EditorialItemModel: Hashable {
  let image: NSImage
  let title: String
  let subtitle: String
  let navigation: URL
}
