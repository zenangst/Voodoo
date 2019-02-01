import UIKit

class EditorialView: UICollectionViewCell, UICollectionViewFeature, StatefulViewController {
  // sourcery: image: UIImage? = "imageView.image = model.image"
  lazy var imageView = UIImageView()
  // sourcery: title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
}
