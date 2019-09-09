//
//  UITableViewModel+UITableViewRegistrar.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

public extension UITableViewRegistrar {
    /// Register any UITableViewNibRegistrables in a UITableViewModel
    ///
    /// - Parameter tableViewModel: a UITableViewModel object
    func register(tableViewModel: UITableViewModel) {
        tableViewModel.forEach({ section in
            self.register(registrables: section.compactMap({ row in
                return row.base as? UITableViewNibRegistrable
            }))
            
            if case .presentable(let header) = section.header, header.base is UITableViewHeaderFooterNibRegistrable {
                self.register(registrable: (header.base as! UITableViewHeaderFooterNibRegistrable))
            }
            
            if case .presentable(let footer) = section.footer, footer.base is UITableViewHeaderFooterNibRegistrable {
                self.register(registrable: (footer.base as! UITableViewHeaderFooterNibRegistrable))
            }
        })
    }
}
