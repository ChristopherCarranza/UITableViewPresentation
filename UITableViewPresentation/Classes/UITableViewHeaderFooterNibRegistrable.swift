//
//  UITableViewHeaderFooterNibRegistrable.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

public protocol UITableViewHeaderFooterNibRegistrable {
    var nib: UINib { get }
    var viewReuseIdentifier: String { get }
}

public extension UITableViewHeaderFooterNibRegistrable {
    /// Nib for use on registration. Protocol extensions default implementation uses the viewReuseIdentifier as the nib name.
    var nib: UINib {
        guard let classType = type(of: self) as? AnyClass else {
            return UINib(nibName: self.viewReuseIdentifier, bundle: nil)
        }
        
        return UINib(nibName: self.viewReuseIdentifier, bundle: Bundle(for: classType))
    }
}

public extension UITableView {
    
    /// Register a UITableViewHeaderFooterNibRegistrable for use in creating new views.
    ///
    /// - Parameter registrable: An object conforming to the UITableViewHeaderFooterNibRegistrable protocol.
    func register(registrable: UITableViewHeaderFooterNibRegistrable) {
        register(registrable.nib, forHeaderFooterViewReuseIdentifier: registrable.viewReuseIdentifier)
    }
    
    /// Register an array of UITableViewHeaderFooterNibRegistrable for use in creating new views.
    ///
    /// - Parameter registrables: An array of objects conforming to the UITableViewHeaderFooterNibRegistrable protocol.
    func register(registrables: [UITableViewHeaderFooterNibRegistrable]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
}
