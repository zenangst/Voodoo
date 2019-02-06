import Cocoa

 // sourcery: let navigation = "URL"
class EditorialItem: NSCollectionViewItem, CollectionViewItemComponent, StatefulItem {
  // sourcery: let image: NSImage = "customImageView.image = model.image"
  lazy var customImageView = NSImageView()
  // sourcery: let title: String = "titleLabel.stringValue = model.title"
  lazy var titleLabel = NSTextField()
  // sourcery: let subtitle: String = "subtitleLabel.stringValue = model.subtitle"
  lazy var subtitleLabel = NSTextField()
  // sourcery: $RawBinding = "view.isEnabled = true"
  lazy var isEnabled: Bool = false

  private var layoutConstraints = [NSLayoutConstraint]()
}
