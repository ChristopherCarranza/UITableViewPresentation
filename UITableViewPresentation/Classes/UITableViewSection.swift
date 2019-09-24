//
//  UITableViewSection.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// A model of a UITableView section.
public struct UITableViewSection {
    
    /// Options for a UITableViewSection Header or Footer
    ///
    /// - none: no header or footer
    /// - blank: a header or footer that is blank and will truncate a tableviews appearance
    /// - title: a standard title
    /// - presentable: a header or footer with a custom presentable header or footer view
    public enum HeaderFooter {
        case none
        case blank
        case title(String)
        case presentable(AnyUITableViewHeaderFooterPresentable)
    }
    
    public let id: AnyHashable
    public let header: HeaderFooter
    public let footer: HeaderFooter
    public let rows: [AnyUITableViewPresentable]
    
    public init<P: UITableViewPresentable>(id: AnyHashable, rows: [P], header: HeaderFooter = .none, footer: HeaderFooter = .none) {
        self.id = id
        self.header = header
        self.footer = footer
        
        /// Box our rows.
        self.rows = rows.map {
            guard !($0 is AnyUITableViewPresentable) else { return $0 as! AnyUITableViewPresentable }
            
            return AnyUITableViewPresentable($0)
        }
    }
    
    public subscript(index: Int) -> AnyUITableViewPresentable {
        get {
            return rows[index]
        }
    }
}

extension UITableViewSection: RandomAccessCollection {
    public var startIndex: Int {
        return rows.startIndex
    }
    
    public var endIndex: Int {
        return rows.endIndex
    }
}

extension UITableViewSection.HeaderFooter: Equatable {
    public static func ==(lhs: UITableViewSection.HeaderFooter, rhs: UITableViewSection.HeaderFooter) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.blank, .blank):
            return true
        case let (.title(a), .title(b)):
            return a == b
        case let (.presentable(a), .presentable(b)):
            return a == b
        default:
            return false
        }
    }
}

extension UITableViewSection: Equatable {
    public static func == (lhs: UITableViewSection, rhs: UITableViewSection) -> Bool {
        if lhs.id != rhs.id { return false }
        if lhs.header != rhs.header { return false }
        if lhs.footer != rhs.footer { return false }
        if lhs.rows != rhs.rows { return false }
        
        return true
    }
}


