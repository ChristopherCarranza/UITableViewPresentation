//
//  UITableViewModelBuilder.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 4/11/22.
//

import Foundation

@resultBuilder
public enum UITableViewModelBuilder {
    public static func buildBlock(_ components: [UITableViewSection]...) -> [UITableViewSection] {
        return components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [UITableViewSection]?) -> [UITableViewSection] {
        return component ?? []
    }
    
    public static func buildExpression(_ expression: UITableViewSection) -> [UITableViewSection] {
        return [expression]
    }
    
    public static func buildEither(first component: [UITableViewSection]) -> [UITableViewSection] {
        return component
    }
    
    public static func buildEither(second component: [UITableViewSection]) -> [UITableViewSection] {
        return component
    }
    
    public static func buildArray(_ components: [[UITableViewSection]]) -> [UITableViewSection] {
        return components.reduce([], +)
    }
}

extension UITableViewModel {
    public init(@UITableViewModelBuilder _ makeSections: () -> [UITableViewSection]) {
        self.init(sections: makeSections())
    }
    
    public init(@UITableViewSectionBuilder _ makeRows: () -> [AnyUITableViewPresentable]) {
        self.init(rows: makeRows())
    }
}

@resultBuilder
public enum UITableViewSectionBuilder {
    public static func buildBlock<T: UITableViewPresentable>(_ components: [T]...) -> [AnyUITableViewPresentable] {
        return components.flatMap({ $0 }).map(AnyUITableViewPresentable.init)
    }
    
    public static func buildOptional(_ component: [AnyUITableViewPresentable]?) -> [AnyUITableViewPresentable] {
        return component ?? []
    }
    
    public static func buildExpression<T: UITableViewPresentable>(_ expression: T) -> [AnyUITableViewPresentable] {
        return [AnyUITableViewPresentable(expression)]
    }
    
    public static func buildEither<T: UITableViewPresentable>(first component: [T]) -> [AnyUITableViewPresentable] {
        return component.map(AnyUITableViewPresentable.init)
    }
    
    public static func buildEither<T: UITableViewPresentable>(second component: [T]) -> [AnyUITableViewPresentable] {
        return component.map(AnyUITableViewPresentable.init)
    }
    
    public static func buildArray<T: UITableViewPresentable>(_ components: [[T]]) -> [AnyUITableViewPresentable] {
        return components.reduce([], +).map(AnyUITableViewPresentable.init)
    }
}

extension UITableViewSection {
    public init(id: AnyHashable = UUID(), header: HeaderFooter = .none, footer: HeaderFooter = .none, @UITableViewSectionBuilder _ makeRows: () -> [AnyUITableViewPresentable]) {
        self.init(id: id, rows: makeRows(), header: header, footer: footer)
    }
}
