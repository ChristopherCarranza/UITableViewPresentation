//
//  UITableViewNibRegistrable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// Allows for the registration of a UITableViewCell from a nib
public protocol UITableViewNibRegistrable {
    var nib: UINib { get }
    var cellReuseIdentifier: String { get }
}

public extension UITableViewNibRegistrable {
    /// Nib for use on registration. Protocol extensions default implementation uses the cellReuseIdentifier as the nib name.
    var nib: UINib {
        return UINib(nibName: cellReuseIdentifier, bundle: nil)
    }
}

public extension UITableView {
    
    /// Register a UITableViewNibRegistrable for use in creating new table cells.
    ///
    /// - Parameter registrable: An object conforming to the UITableViewNibRegistrable protocol.
    func register(registrable: UITableViewNibRegistrable) {
        register(registrable.nib, forCellReuseIdentifier: registrable.cellReuseIdentifier)
    }
    
    /// Register an array of UITableViewNibRegistrable for use in creating new table cells.
    ///
    /// - Parameter registrables: An array of objects conforming to the UITableViewNibRegistrable protocol.
    func register(registrables: [UITableViewNibRegistrable]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
}
