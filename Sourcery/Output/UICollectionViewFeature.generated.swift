// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

class EditorialViewController: UIViewController {
  private let layout: UICollectionViewFlowLayout
  private let collectionView: UICollectionView
  private let dataSource = EditorialViewDataSource()

  init(layout: UICollectionViewFlowLayout, collectionView: UICollectionView?) {
    self.layout = layout
    if let collectionView = collectionView {
      self.collectionView = collectionView
    } else {
      self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    }
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    self.view = collectionView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = dataSource
    collectionView.register(EditorialView.self, forCellWithReuseIdentifier: "EditorialView")
  }
}

class EditorialViewDataSource: NSObject, UICollectionViewDataSource {

  private var models = [EditorialViewModel]()

  init(models: [EditorialViewModel] = []) {
    self.models = models
    super.init()
  }

  func model(at indexPath: IndexPath) -> EditorialViewModel {
    return models[indexPath.item]
  }

  func reload(_ collectionView: UICollectionView,
              with models: [EditorialViewModel]) {
    self.models = models
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditorialView", for: indexPath)
    let model = self.model(at: indexPath)

    if let view = cell as? EditorialView {
      view.imageView.image = model.image
      view.titleLabel.text = model.titleLabel
      view.subtitleLabel.text = model.subtitleLabel
    }

    return cell
  }
}

struct EditorialViewModel: Hashable {
  let image: UIImage 
  let titleLabel: String 
  let subtitleLabel: String 
}
