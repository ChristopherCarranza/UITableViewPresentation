//
//  ZeroConfigurationPresenter.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

public struct ZeroConfigurationPresenter: UITableViewPresentable {
    public let cellReuseIdentifier: String
    
    public init(cellReuseIdentifier: String) {
        self.cellReuseIdentifier = cellReuseIdentifier
    }
    
    public func configure(cell: UITableViewCell, at indexPath: IndexPath) {}
    
    public static func == (lhs: ZeroConfigurationPresenter, rhs: ZeroConfigurationPresenter) -> Bool {
        guard lhs.cellReuseIdentifier != rhs.cellReuseIdentifier else { return false }
        
        return true
    }
}

extension ZeroConfigurationPresenter: UITableViewNibRegistrable {}
