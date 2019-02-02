import Cocoa

 // sourcery: navigation = "URL"
class EditorialItem: NSCollectionViewItem, CollectionViewItemComponent, StatefulItem {
  // sourcery: image: NSImage = "customImageView.image = model.image"
  lazy var customImageView = NSImageView()
  // sourcery: title: String = "titleLabel.stringValue = model.title"
  lazy var titleLabel = NSTextField()
  // sourcery: subtitle: String = "subtitleLabel.stringValue = model.subtitle"
  lazy var subtitleLabel = NSTextField()

  private var layoutConstraints = [NSLayoutConstraint]()
}
