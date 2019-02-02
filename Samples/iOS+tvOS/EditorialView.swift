import UIKit

// sourcery: navigation = "URL"
class EditorialView: UICollectionViewCell, CollectionViewComponent, StatefulView {
  // sourcery: image: UIImage? = "imageView.image = model.image"
  lazy var imageView = UIImageView()
  // sourcery: title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
}
