//
//  Dwifft+UITableViewModel.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import Dwifft

public extension Dwifft {
    
    /// For pure equatability we leave the `UITableViewSection` as is (every property equal).
    /// However for diffing purposes we only want to look at section specific properties as
    /// `Dwifft` looks at the section and rows separately. This separate object is used
    /// only for diffing purposes.
    internal struct UITableViewSectionDiffModel: Equatable {
        let header: UITableViewSection.HeaderFooter
        let footer: UITableViewSection.HeaderFooter
        
        init(_ section: UITableViewSection) {
            header = section.header
            footer = section.footer
        }
        
        internal static func == (lhs: UITableViewSectionDiffModel, rhs: UITableViewSectionDiffModel) -> Bool {
            if lhs.header != rhs.header { return false }
            if lhs.footer != rhs.footer { return false }
            
            return true
        }
    }
    
    /// Creates a diff between table view models.
    ///
    /// - Parameters:
    ///   - lhs: a table view model
    ///   - rhs: a table view model
    /// - Returns: the series of transformations that, when applied to `lhs`, will yield `rhs`.
    internal static func diff(lhs: UITableViewModel, rhs: UITableViewModel) -> [SectionedDiffStep<UITableViewSectionDiffModel, AnyUITableViewPresentable>] {
        return diff(lhs: tableViewModelConverter(model: lhs), rhs: tableViewModelConverter(model: rhs))
    }
    
    /// Converts a model to a SectionedValues object that `Dwifft` understands.
    ///
    /// - Parameter model: a table view model
    /// - Returns: a SectionedValues object
    private static func tableViewModelConverter(model: UITableViewModel) -> SectionedValues<UITableViewSectionDiffModel, AnyUITableViewPresentable> {
        return SectionedValues(model.map { section in
            return (UITableViewSectionDiffModel(section), section.rows)
        })
    }
}
