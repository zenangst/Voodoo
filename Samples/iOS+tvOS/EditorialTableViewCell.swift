import UIKit

// sourcery: let navigation = "URL"
class EditorialTableViewCell: UITableViewCell, TableViewComponent, StatefulView {
  // sourcery: let image: UIImage? = "posterView.image = model.image"
  lazy var posterView = UIImageView()
  // sourcery: let title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: let subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
}
