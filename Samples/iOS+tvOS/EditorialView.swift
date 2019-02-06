import UIKit

// sourcery: let navigation = "URL"
class EditorialView: UICollectionViewCell, CollectionViewComponent, StatefulView {
  // sourcery: let image: UIImage? = "imageView.image = model.image"
  lazy var imageView = UIImageView()
  // sourcery: let title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: let subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
  // sourcery: $RawBinding = "view.isEnabled = true"
  lazy var isEnabled: Bool = false
}
