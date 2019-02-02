![Voodoo logo](https://github.com/zenangst/Voodoo/blob/master/Images/Voodoo-header_v2.png?raw=true)

Voodoo is a set of [Sourcery](https://github.com/krzysztofzablocki/Sourcery) templates to make you do more with less.

|Feature | macOS | iOS | tvOS |
|:---|:---:|:---:|:---:|
| Collection view components  | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/macOS/CollectionViewItemComponent.stencil) | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/CollectionViewComponent.stencil) | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/CollectionViewComponent.stencil)
| Table view components  | ❌ Not supported | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/TableViewComponent.stencil) | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/TableViewComponent.stencil)
| State controllers  | 🚜 Coming | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/StatefulView.stencil) | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/StatefulView.stencil)
| View controller factory  | 🚜 Coming | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/ViewControllerFactory.stencil) | ✅ [Template](https://github.com/zenangst/Voodoo/blob/master/Templates/iOS%2BtvOS/ViewControllerFactory.stencil)

## Description

<img src="https://github.com/zenangst/Voodoo/blob/master/Images/Voodoo-icon_v2.png?raw=true" alt="Voodoo Icon" align="right" />

Cocoa development comes with a lot of "boilerplate" which can often slow down progress because of the repetitive chunks of code that we always have to apply to render our data as UI.

Take a collection view, for example; you need a controller to add your collection view on screen, in addition to that, you need supply a data source for your collection view so that it knows what to display. But the fun doesn't stop there. You also need a cell which the collection view requires to register to be able to dequeue when rendering the data on the screen. And last but not least, you need a model to configure your views with; otherwise your views are just skeletons without any skin.

This process is probably something that you've implemented multiple times, which is not really an issue in itself but as your codebase grows, you continue to add more and more collection views, all just a little bit different, different models and different views but all in all, at their core it's the same setup code for all of them (more or less).

This is where Voodoo comes in, and it aims to help to reduce the amount of code needed to get started and probably more important, to maintain your codebase as it grows.

## Usage

### Generating features using views

**Note** the built-in templates are made to provide you with a starting point. You should invest time in taking ownership and making them your own. There are no such things as one size fits all when it comes to code generation at this level.

The idea is to have your views conform to a protocol called `CollectionViewComponent` which generates the following.

- A view controller
- A data source
- A view specific model
- View model data binding based on `sourcery` annotations.

```swift
import UIKit

class EditorialView: UICollectionViewCell, CollectionViewComponent {
  // sourcery: image: UIImage? = "imageView.image = model.image"
  lazy var imageView = UIImageView()
  // sourcery: title: String = "titleLabel.text = model.title"
  lazy var titleLabel = UILabel()
  // sourcery: subtitle: String = "subtitleLabel.text = model.subtitle"
  lazy var subtitleLabel = UILabel()
}
```

Looking at the code example above, the following would be generated:

```swift
class EditorialViewController: UIViewController {
  ...
  collectionView.register(EditorialView.self, forCellWithReuseIdentifier: "EditorialView")
  ...
}
class EditorialViewDataSource: NSObject, UICollectionViewDataSource {
  ...
  if let view = cell as? EditorialView {
    view.imageView.image = model.image
    view.titleLabel.text = model.title
    view.subtitleLabel.text = model.subtitle
  }
  ...
}
struct EditorialViewModel: Hashable {
  let image: UIImage?
  let title: String
  let subtitle: String
}
```

If we take a closer look at the annotations:

```
// sourcery: image: UIImage? = "imageView.image = model.image"
```

The first part which acts as the key for the annotation is used to create the model property.
The latter part is used for data binding, by wrapping it in quotes, we can tailor the
binding to our needs. If we wanted to use a third-party library or our image data loading
class to fetch and display images, we could easily do that across the application by changing
the sourcery annotation.

By generating code this way, we get a pretty groove side-effect which is dependency containment.
Changing the annotation and regenerating the feature would instantly swap or remove the dependency
just by hitting build.

So this is all good, but what about customization points? If everything is generated, how can we tailor
each individual view controller to our application needs. Well, if you see that you view controller is starting
change direction and is non-generic (not to be confused with Swift generics). You can simply copy the code the generate code out and use that as your start point for your feature. Choosing the best direction
for your app is really up to you, no generator tools can help you there, but generating your starting point
will save your countless amount of time.

There is also a different route that can give you some customization options which is to consider your view controllers as pure data representations and handle your delegate needs using a container view controller.
This would mean that you add your generated view controllers as child view controllers and the container (or any other class) acts as the delegate for the view controller.

One other benefit of generating view controllers with corresponding models is that they can easily be mocked which makes them perfect for rapid development. Think about it, they can be used and displayed on the screen without knowing any additional details about your business logic. They only know how to display the data that you provided with your sourcery annotations. Having domain-specific models makes sure that you are not creating models that carry more weight than they need to, they also but a bandaid on any business logic related scars that may bleed into your feature.

### Generating state controllers

State handling and naming this are probably the two hardest things when it comes to programming (I chose to exclude timezones out of spite). State containment can be handled in many different ways. Voodoo provides a way to generate state controllers for your generated features. By conforming to `StatefulView` on your `CollectionViewComponent`, a state controller will be generated which has the following states.

- Initial
- Loading
- Failure
- Success

The `.success` state is coupled to the generated feature view controller, taking the user domain model as the argument for the state case.

```swift
enum EditorialViewState {
  case initial
  case loading
  case failure(error: Error)
  case success(models: [EditorialViewModel])
}

class EditorialViewStateController: UIViewController {
  typealias ErrorViewController = EditorialErrorViewController & UIViewController

  private let initialViewController: UIViewController
  private let loadingViewController: UIViewController
  private let failureViewController: ErrorViewController
  private let successController: EditorialViewController

  init(initialViewController: UIViewController,
       loadingViewController: UIViewController,
       failureViewController: ErrorViewController,
       successController: EditorialViewController) {
    self.initialViewController = initialViewController
    self.loadingViewController = loadingViewController
    self.failureViewController = failureViewController
    self.successController = successController
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render(_ state: EditorialViewState) {
    children.forEach {
      $0.removeFromParent()
    }
    let viewController: UIViewController
    switch state {
    case .initial:
      viewController = initialViewController
    case .loading:
      viewController = loadingViewController
    case .failure(let error):
      viewController = failureViewController
      failureViewController.error = error
    case .success(let models):
      viewController = successController
      successController.reload(with: models)
    }
    viewController.willMove(toParent: self)
    addChild(viewController)
    viewController.view.frame = view.bounds
    view.addSubview(viewController.view)
    viewController.didMove(toParent: self)
  }
}
```

All view controllers except for `successController` are kept as regular view controllers to give you maximum flexibility.

## Author

- Christoffer Winterkvist, [@zenangst](https://github.com/zenangst)
- Markus Halvorsen, [@MarkusHalvorsen](https://twitter.com/MarkusHalvorsen)

## Contributing

If you have ideas on how to expand Voodoo, open an issue and we'll collaborate.

## Credit

At it's core, Voodoo uses [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to generate its output so it is important to study and learn that piece of software to get the most out of code generation. Without Sourcery, Voodoo is nothing.
A special thanks to all the contributers of [Sourcery](https://github.com/krzysztofzablocki/Sourcery), and a very special shout-out to [Krzysztof Zabłocki](https://github.com/krzysztofzablocki) for creating and sharing Sourcery with the community. ❤️

## License

**Voodoo** is available under the MIT license. See the [LICENSE](https://github.com/zenangst/Voodoo/blob/master/LICENSE.md) file for more info.
