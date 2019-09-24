//
//  UITableViewHeaderFooterPresentable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

/// Provides the ability to dequeue and configure a UITableViewHeaderFooterPresentable for a UITableView.
public protocol UITableViewHeaderFooterPresentable: Equatable {
    associatedtype HeaderFooterView: UITableViewHeaderFooterView
    
    /// Identifier that should match the views reuseIdentifier property.
    ///
    /// - Note: This defaults to the class name of the view used in the presentable.
    var viewReuseIdentifier: String { get }
    
    func configure(view: HeaderFooterView, for section: Int)
}

public extension UITableViewHeaderFooterPresentable {
    var viewReuseIdentifier: String {
        return String(describing: HeaderFooterView.self)
    }
}

public extension UITableView {
    
    /// Dequeues a UITableViewHeaderFooterView of a type associated with the given presentable object.
    ///
    /// - Parameters:
    ///   - presentable: An object conforming to the UITableViewHeaderFooterView protocol.
    /// - Returns: A UITableViewHeaderFooterView of the type specified in the given presentable.
    func dequeReusableHeaderFooterView<T: UITableViewHeaderFooterPresentable>(presentable: T) -> T.HeaderFooterView? {
        return dequeueReusableHeaderFooterView(withIdentifier: presentable.viewReuseIdentifier) as? T.HeaderFooterView
    }
}

// MARK: - AnyUITableViewHeaderFooterView
//https://github.com/apple/swift/blob/master/stdlib/public/core/AnyHashable.swift

/// Used internally to `erase` the type used with UITableViewHeaderFooterPresentable
internal protocol _AnyUITableViewHeaderFooterPresentableBox {
    var _base: Any { get }
    var _viewReuseIdentifier: String { get }
    func _configure(view: UITableViewHeaderFooterView, for section: Int)
    func _unbox<T: UITableViewHeaderFooterPresentable>() -> T?
    func _isEqual(to: _AnyUITableViewHeaderFooterPresentableBox) -> Bool?
}

internal struct _ConcreteUITableViewHeaderFooterPresentableBox<Base: UITableViewHeaderFooterPresentable>: _AnyUITableViewHeaderFooterPresentableBox {
    private var _baseUITableViewHeaderFooterPresentable: Base
    
    public init(_ base: Base) {
        self._baseUITableViewHeaderFooterPresentable = base
    }
    
    internal func _unbox<T>() -> T? where T : UITableViewHeaderFooterPresentable {
        return (self as _AnyUITableViewHeaderFooterPresentableBox as? _ConcreteUITableViewHeaderFooterPresentableBox<T>)?._baseUITableViewHeaderFooterPresentable
    }
    
    internal func _isEqual(to rhs: _AnyUITableViewHeaderFooterPresentableBox) -> Bool? {
        if let rhs: Base = rhs._unbox() {
            return _baseUITableViewHeaderFooterPresentable == rhs
        }
        
        return nil
    }
    
    public var _base: Any {
        return _baseUITableViewHeaderFooterPresentable
    }
    
    public var _viewReuseIdentifier: String {
        return _baseUITableViewHeaderFooterPresentable.viewReuseIdentifier
    }
    
    public func _configure(view: UITableViewHeaderFooterView, for section: Int) {
        _baseUITableViewHeaderFooterPresentable.configure(view: view as! Base.HeaderFooterView, for: section)
    }
}

/// A type-erased UITableViewHeaderFooterPresentable value.
///
/// This allows for the storage of mixed type UITableViewHeaderFooterView values in collections
/// that require `UITableViewHeaderFooterPresentable` conformance by wrapping mixed view type objects
/// in AnyUITableViewHeaderFooterPresentable instances.
public struct AnyUITableViewHeaderFooterPresentable {
    internal var _box: _AnyUITableViewHeaderFooterPresentableBox
    
    public init<P: UITableViewHeaderFooterPresentable>(_ base: P) {
        self._box = _ConcreteUITableViewHeaderFooterPresentableBox(base)
    }
    
    public var base: Any {
        return _box._base
    }
}

extension AnyUITableViewHeaderFooterPresentable: UITableViewHeaderFooterPresentable {
    public var viewReuseIdentifier: String {
        return _box._viewReuseIdentifier
    }
    
    public func configure(view: UITableViewHeaderFooterView, for section: Int) {
        _box._configure(view: view, for: section)
    }
}

extension AnyUITableViewHeaderFooterPresentable: Equatable {
    public static func == (lhs: AnyUITableViewHeaderFooterPresentable, rhs: AnyUITableViewHeaderFooterPresentable) -> Bool {
        if let result = lhs._box._isEqual(to: rhs._box) { return result }
        
        return false
    }
}


