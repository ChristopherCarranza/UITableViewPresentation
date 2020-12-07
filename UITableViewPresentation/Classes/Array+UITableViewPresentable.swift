//
//  Array+UITableViewPresentable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 12/2/20.
//

import Foundation

extension Array where Element == AnyUITableViewPresentable {
    @inlinable public mutating func append<P: UITableViewPresentable>(_ newElement: P) {
        append(Array.boxRow(newElement))
    }
    
    @inlinable public mutating func append<P>(contents newElements: P) where P: Sequence, P.Element: UITableViewPresentable {
        append(contentsOf: Array.boxRows(newElements))
    }
    
    @inlinable public mutating func insert<P: UITableViewPresentable>(_ newElement: P, at i: Int) {
        insert(Array.boxRow(newElement), at: i)
    }
    
    @inlinable public mutating func insert<P>(contents newElements: P, at i: Int) where P: Sequence, P.Element: UITableViewPresentable {
        insert(contentsOf: Array.boxRows(newElements), at: i)
    }
    
    public static func boxRow<P: UITableViewPresentable>(_ row: P) -> AnyUITableViewPresentable {
        guard !(row is AnyUITableViewPresentable) else { return row as! AnyUITableViewPresentable }
        
        return AnyUITableViewPresentable(row)
    }
    
    public static func boxRows<P>(_ rows: P) -> [AnyUITableViewPresentable]  where P: Sequence, P.Element: UITableViewPresentable  {
        return rows.map {
            return boxRow($0)
        }
    }
}
