import UIKit

class EditorialTableViewCell: UITableViewCell, UITableViewFeature {
  // sourcery: image: UIImage? = "posterView.image = model.image"
  lazy var posterView = UIImageView()
  // sourcery: title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
}
