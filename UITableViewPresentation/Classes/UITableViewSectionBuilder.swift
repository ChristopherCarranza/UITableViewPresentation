//
//  UITableViewSectionBuilder.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 10/1/19.
//

import Foundation

/// A class to make building UITableViewSection's easier
public class UITableViewSectionBuilder {
    
    private var id: AnyHashable = "Default"
    private var header: UITableViewSection.HeaderFooter = .none
    private var footer: UITableViewSection.HeaderFooter = .none
    private var rows: [AnyUITableViewPresentable] = []
    
    public init() {}
    
    @discardableResult
    public func withId(_ id: AnyHashable) -> UITableViewSectionBuilder {
        self.id = id
        return self
    }
    
    @discardableResult
    public func withHeader(_ header: UITableViewSection.HeaderFooter) -> UITableViewSectionBuilder {
        self.header = header
        return self
    }
    
    @discardableResult
    public func withHeaderPresentable<P: UITableViewHeaderFooterPresentable>(_ header: P) -> UITableViewSectionBuilder {
        self.header = .presentable(UITableViewSectionBuilder.boxHeaderFooter(header))
        return self
    }
    
    @discardableResult
    public func withFooter(_ footer: UITableViewSection.HeaderFooter) -> UITableViewSectionBuilder {
        self.footer = footer
        return self
    }
    
    @discardableResult
    public func withFooterPresentable<P: UITableViewHeaderFooterPresentable>(_ footer: P) -> UITableViewSectionBuilder {
        self.footer = .presentable(UITableViewSectionBuilder.boxHeaderFooter(footer))
        return self
    }
    
    @discardableResult
    public func withRows<P: UITableViewPresentable>(_ rows: [P]) -> UITableViewSectionBuilder {
        self.rows = UITableViewSectionBuilder.boxRows(rows)
        return self
    }
    
    @discardableResult
    public func addRow<P: UITableViewPresentable>(_ row: P) -> UITableViewSectionBuilder {
        return addRows([row])
    }
    
    @discardableResult
    public func addRows<P: UITableViewPresentable>(_ rows: [P]) -> UITableViewSectionBuilder {
        self.rows.append(contentsOf: UITableViewSectionBuilder.boxRows(rows))
        
        return self
    }
    
    private static func boxHeaderFooter<P: UITableViewHeaderFooterPresentable>(_ headerFooter: P) -> AnyUITableViewHeaderFooterPresentable {
        guard !(headerFooter is AnyUITableViewHeaderFooterPresentable) else { return headerFooter as! AnyUITableViewHeaderFooterPresentable }
        
        return AnyUITableViewHeaderFooterPresentable(headerFooter)
    }
    
    private static func boxRows<P: UITableViewPresentable>(_ rows: [P]) -> [AnyUITableViewPresentable] {
        return rows.map {
            guard !($0 is AnyUITableViewPresentable) else { return $0 as! AnyUITableViewPresentable }
            
            return AnyUITableViewPresentable($0)
        }
    }
    
    /// Builds the final immutable UITableViewSection
    public func build() -> UITableViewSection {
        return UITableViewSection(id: id, rows: rows, header: header, footer: footer)
    }
}
