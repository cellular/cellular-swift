#if os(iOS) || os(tvOS)
import UIKit
import Foundation

/// An identifier to be used as native representation of a string based storyboard value.
public protocol StoryboardIdentifier: RawRepresentable where Self.RawValue == String {}

extension UIStoryboard {

    /// Creates and returns a storyboard object for the specified storyboard resource file.
    ///
    /// - Parameters:
    ///   - identifier: The identifier of the storyboard resource file without the filename extension.
    ///   - bundle:
    ///         The bundle containing the storyboard file and its related resources.
    ///         If you specify nil, this method looks in the main bundle of the current application.
    public convenience init<Identifier>(identifier: Identifier, bundle bundleOrNil: Bundle? = nil)
        where Identifier: StoryboardIdentifier {
            self.init(name: identifier.rawValue, bundle: bundleOrNil)
    }

    /// Instantiates and returns the view controller with the specified identifier.
    ///
    /// - Parameter identifier: An identifier string that uniquely identifies the view controller in the storyboard file.
    /// - Returns:
    ///     The view controller corresponding to the specified identifier string.
    ///     If no view controller is associated with the string, this method throws an exception.
    public func instantiateViewController<Identifier>(with identifier: Identifier)
        -> UIViewController where Identifier: StoryboardIdentifier {
            return instantiateViewController(withIdentifier: identifier.rawValue)
    }
}

extension UIStoryboardSegue {

    /// The identifier for the segue object of given concrete type.
    ///
    /// - Parameter type: The type to which the identifier should be mapped and returned as concrete instance.
    /// - Returns: An instance of `Identifier` representing the raw value of the storyboard as a concrete instance. `nil` if none found.
    public func identifier<Identifier>(of type: Identifier.Type) -> Identifier? where Identifier: StoryboardIdentifier {
        return identifier.flatMap(Identifier.init(rawValue:))
    }
}

extension UIViewController {

    /// Returns a newly initialized view controller with the nib file in the specified bundle.
    ///
    /// - Parameters:
    ///   - identifier: The identifier of the nib file to associate with the view controller.
    ///   - bundle:
    ///         The bundle containing the nib file and its related resources.
    ///         If you specify nil, this method looks in the main bundle of the current application.
    public convenience init<Identifier>(identifier: Identifier, bundle nibBundleOrNil: Bundle? = nil)
        where Identifier: StoryboardIdentifier {
            self.init(nibName: identifier.rawValue, bundle: nibBundleOrNil)
    }

    /// Initiates the segue with the specified identifier from the current view controller's storyboard file.
    ///
    /// - Parameters:
    ///   - identifier:
    ///       The segue identifier of the segue to be triggered.
    ///       In Interface Builder, you specify the segue’s identifier string in the attributes inspector.
    ///       This method throws an Exception handling if there is no segue with the specified identifier.
    ///   - sender:
    ///       The object that you want to use to initiate the segue.
    ///       This object is made available for informational purposes during the actual segue.
    public func performSegue<Identifier>(withIdentifier identifier: Identifier, sender: Any?)
        where Identifier: StoryboardIdentifier {
            self.performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
}
#endif
