//
//  UITableViewRegistrable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// Allows for the registration of a UITableViewCell.
public protocol UITableViewRegistrable: class {
    associatedtype TableViewCell: UITableViewCell
    var cellReuseIdentifier: String { get }
}

public extension UITableView {
    
    /// Register a UITableViewRegistrable for use in creating new table cells.
    ///
    /// - Parameter registrable: An object conforming to the UITableViewRegistrable protocol.
    func register<R: UITableViewRegistrable>(registrable: R) {
        register(R.TableViewCell.self, forCellReuseIdentifier: registrable.cellReuseIdentifier)
    }
    
    /// Register an array of UITableViewRegistrables for use in creating new table cells.
    ///
    /// - Parameter registrables: An array of objects conforming to the UITableViewRegistrable protocol.
    func register<R: UITableViewRegistrable>(registrables: [R]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
}
