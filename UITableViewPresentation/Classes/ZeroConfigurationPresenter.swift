//
//  ZeroConfigurationPresenter.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

public struct ZeroConfigurationPresenter: UITableViewPresentable {
    public let id: AnyHashable
    public let cellReuseIdentifier: String
    private let _nib: UINib?
    
    public init(id: AnyHashable, cellReuseIdentifier: String, nib: UINib? = nil) {
        self.id = id
        self.cellReuseIdentifier = cellReuseIdentifier
        self._nib = nib
    }
    
    public func configure(cell: UITableViewCell, at indexPath: IndexPath) {}
    
    public var nib: UINib {
        return _nib ?? UINib(nibName: cellReuseIdentifier, bundle: nil)
    }
    
    public static func == (lhs: ZeroConfigurationPresenter, rhs: ZeroConfigurationPresenter) -> Bool {
        return lhs.id == rhs.id
    }
}
