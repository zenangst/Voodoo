// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

class EditorialTableViewController: UIViewController {
  private let tableView: UITableView
  private let dataSource = EditorialTableViewDataSource()

  init(tableView: UITableView? = nil) {
    if let tableView = tableView {
      self.tableView = tableView
    } else {
      self.tableView = UITableView(frame: .zero)
    }
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func loadView() {
    self.view = tableView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = dataSource
    tableView.register(EditorialTableViewCell.self, forCellReuseIdentifier: "EditorialTableViewCell")
  }

  // MARK: - Public API

  func reload(with models: [EditorialTableViewCellModel]) {
    dataSource.reload(tableView, with: models)
  }
}

class EditorialTableViewDataSource: NSObject, UITableViewDataSource {
  private var models = [EditorialTableViewCellModel]()

  init(models: [EditorialTableViewCellModel] = []) {
    self.models = models
    super.init()
  }

  // MARK: - Public API

  func model(at indexPath: IndexPath) -> EditorialTableViewCellModel {
    return models[indexPath.item]
  }

  func reload(_ tableView: UITableView,
              with models: [EditorialTableViewCellModel]) {
    self.models = models
    tableView.reloadData()
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EditorialTableViewCell", for: indexPath)
    let model = self.model(at: indexPath)

    if let view = cell as? EditorialTableViewCell {
      view.posterView.image = model.image
      view.titleLabel.text = model.title
      view.subtitleLabel.text = model.subtitle
    }

    return cell
  }
}

struct EditorialTableViewCellModel: Hashable {
  let image: UIImage?
  let title: String
  let subtitle: String
  let navigation: URL
}
