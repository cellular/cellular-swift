#if os(iOS) || os(tvOS)
import UIKit
import Foundation

/// An identifier to be used as native representation of a string based storyboard value
public protocol StoryboardIdentifier: RawRepresentable where Self.RawValue == String {}

public extension UIStoryboard {

    /// Creates and returns a storyboard object for the specified storyboard resource file.
    ///
    /// - Parameters:
    ///   - identifier: The identifier of the storyboard resource file without the filename extension.
    ///   - bundle:
    ///         The bundle containing the storyboard file and its related resources.
    ///         If you specify nil, this method looks in the main bundle of the current application.
    public convenience init<Identifier: StoryboardIdentifier>(identifier: Identifier, bundle bundleOrNil: Bundle? = nil) {
        self.init(name: identifier.rawValue, bundle: bundleOrNil)
    }

    /// Instantiates and returns the view controller with the specified identifier.
    ///
    /// - Parameter identifier:  An identifier string that uniquely identifies the view controller in the storyboard file.
    /// - Returns:
    ///         The view controller corresponding to the specified identifier string.
    ///         If no view controller is associated with the string, this method throws an exception.
    public func instantiateViewController<Identifier: StoryboardIdentifier>(with identifier: Identifier) -> UIViewController {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }
}

public extension UIStoryboardSegue {

    /// The identifier for the segue object of given concrete type.
    ///
    /// - Parameter type: The type to which the identifier should be mapped and returned as concrete instance.
    /// - Returns: An instance of `Identifier` representing the raw value of the storyboard as a concrete instance. `nil` if none found.
    public func identifier<Identifier>(of type: Identifier.Type) -> Identifier? where Identifier: StoryboardIdentifier {
        return identifier.flatMap(Identifier.init(rawValue:))
    }
}
#endif
