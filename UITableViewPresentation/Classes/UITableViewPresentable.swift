//
//  UITableViewPresentable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// Provides the ability to dequeue and configure a UITableViewCell for a UITableView.
public protocol UITableViewPresentable: Equatable {
    associatedtype TableViewCell: UITableViewCell
    
    /// Identifier that should match the cells cellReuseIdentifier property.
    ///
    /// - Note: This defaults to the class name of the cell used in the presentable
    var cellReuseIdentifier: String { get }
    
    func configure(cell: TableViewCell, at indexPath: IndexPath)
}

public extension UITableViewPresentable {
    var cellReuseIdentifier: String {
        return String(describing: TableViewCell.self)
    }
}

public extension UITableView {
    
    /// Dequeues a UITableViewCell of a type associated with the given presentable object.
    ///
    /// - Parameters:
    ///   - presentable: An object conforming to the UITableViewPresentable protocol.
    ///   - indexPath: The indexPath for the UITableViewCell.
    /// - Returns: A UITableViewCell of the type specified in the given presentable.
    func dequeReusableCell<T: UITableViewPresentable>(presentable: T, for indexPath: IndexPath) -> T.TableViewCell? {
        return dequeueReusableCell(withIdentifier: presentable.cellReuseIdentifier, for: indexPath) as? T.TableViewCell
    }
}

// MARK: - AnyUITableViewPresentable
//https://github.com/apple/swift/blob/master/stdlib/public/core/AnyHashable.swift

/// Used internally to `erase` the type used with UITableViewPresentable
internal protocol _AnyUITableViewPresentableBox {
    var _base: Any { get }
    var _cellReuseIdentifier: String { get }
    func _configure(cell: UITableViewCell, at indexPath: IndexPath)
    func _unbox<T: UITableViewPresentable>() -> T?
    func _isEqual(to: _AnyUITableViewPresentableBox) -> Bool?
}

internal struct _ConcreteUITableViewPresentableBox<Base: UITableViewPresentable>: _AnyUITableViewPresentableBox {
    private var _baseUITableViewPresentable: Base
    
    public init(_ base: Base) {
        self._baseUITableViewPresentable = base
    }
    
    internal func _unbox<T: UITableViewPresentable>() -> T? {
        return (self as _AnyUITableViewPresentableBox as? _ConcreteUITableViewPresentableBox<T>)?._baseUITableViewPresentable
    }
    
    internal func _isEqual(to rhs: _AnyUITableViewPresentableBox) -> Bool? {
        if let rhs: Base = rhs._unbox() {
            return _baseUITableViewPresentable == rhs
        }
        
        return nil
    }
    
    public var _base: Any {
        return _baseUITableViewPresentable
    }
    
    public var _cellReuseIdentifier: String {
        return _baseUITableViewPresentable.cellReuseIdentifier
    }
    
    public func _configure(cell: UITableViewCell, at indexPath: IndexPath) {
        _baseUITableViewPresentable.configure(cell: cell as! Base.TableViewCell, at: indexPath)
    }
}

/// A type-erased UITableViewPresentable value.
///
/// This allows for the storage of mixed type UITableViewCell values in collections
/// that require `UITableViewPresentable` conformance by wrapping mixed cell type objects
/// in AnyUITableViewPresentable instances.
public struct AnyUITableViewPresentable {
    internal var _box: _AnyUITableViewPresentableBox

    public init<P: UITableViewPresentable>(_ base: P) {
        self._box = _ConcreteUITableViewPresentableBox(base)
    }
    
    public var base: Any {
        return _box._base
    }
}

extension AnyUITableViewPresentable: UITableViewPresentable {
    public var cellReuseIdentifier: String {
        return _box._cellReuseIdentifier
    }
    
    public func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        _box._configure(cell: cell, at: indexPath)
    }
}

extension AnyUITableViewPresentable: Equatable {
    public static func == (lhs: AnyUITableViewPresentable, rhs: AnyUITableViewPresentable) -> Bool {
        if let result = lhs._box._isEqual(to: rhs._box) { return result }
        
        return false
    }
}
