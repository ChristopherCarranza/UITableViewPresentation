//
//  UITableViewModel.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// A model that emulates a tableView data structure of sections with rows.
public struct UITableViewModel {
    fileprivate let sections: [UITableViewSection]
    
    public init(sections: [UITableViewSection]) {
        self.sections = sections
    }
    
    public subscript(index: Int) -> UITableViewSection {
        get {
            return sections[index]
        }
    }
    
    public subscript(indexPath: IndexPath) -> AnyUITableViewPresentable {
        get {
            return sections[indexPath.section][indexPath.row]
        }
    }
}

extension UITableViewModel {
    public init<P: UITableViewPresentable>(rows: [P]) {
        sections = [UITableViewSection(rows: rows)]
    }
}

extension UITableViewModel: RandomAccessCollection {
    public var startIndex: Int {
        return sections.startIndex
    }
    
    public var endIndex: Int {
        return sections.endIndex
    }
}

extension UITableViewModel: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: UITableViewSection...) {
        self.init(sections: elements)
    }
}

extension UITableViewModel: Equatable {
    public static func == (lhs: UITableViewModel, rhs: UITableViewModel) -> Bool {
        if lhs.sections != rhs.sections { return false }
        
        return true
    }
}


