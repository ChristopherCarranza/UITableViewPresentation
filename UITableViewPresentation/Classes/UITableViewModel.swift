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
    public var sections: [UITableViewSection]
    
    public init(sections: [UITableViewSection]) {
        self.sections = sections
    }
    
    public subscript(index: Int) -> UITableViewSection {
        get {
            sections[index]
        }
        set(newValue) {
            sections[index] = newValue
        }
    }
    
    public subscript(indexPath: IndexPath) -> AnyUITableViewPresentable {
        get {
            sections[indexPath.section][indexPath.row]
        }
        set(newValue) {
            sections[indexPath.section][indexPath.row] = newValue
        }
    }
}

extension UITableViewModel {
    public init<P: UITableViewPresentable>(rows: [P]) {
        sections = [UITableViewSection(id: "Default", rows: rows)]
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
