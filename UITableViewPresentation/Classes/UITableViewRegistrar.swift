//
//  UITableViewRegistrar.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

/// Used to track which Registrables have been registered to a tableview
public final class UITableViewRegistrar {
    private weak var tableView: UITableView!
    private var cellIdentifiers: Set<String> = []
    private var headerFooterViewIdentifiers: Set<String> = []
    
    public init<R: UITableViewRegistrable>(tableView: UITableView, registrables: [R] = []) {
        self.tableView = tableView
        register(registrables: registrables)
    }
    
    public init(tableView: UITableView, registrables: [UITableViewNibRegistrable] = []) {
        self.tableView = tableView
        
        guard !registrables.isEmpty else { return }
        register(registrables: registrables)
    }
    
    /// Register a UITableViewRegistrable object if not already registered.
    ///
    /// - Parameter registrable: a UITableViewRegistrable object.
    public func register<R: UITableViewRegistrable>(registrable: R) {
        guard !cellIdentifiers.contains(registrable.cellReuseIdentifier) else { return }
        
        tableView.register(registrable: registrable)
        cellIdentifiers.insert(registrable.cellReuseIdentifier)
    }
    
    /// Registers an array of UITableViewRegistrable objects if not already registered.
    ///
    /// - Parameter registrables: an array of UITableViewRegistrable objects.
    public func register<R: UITableViewRegistrable>(registrables: [R]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
    
    /// Register a UITableViewNibRegistrable object if not already registered.
    ///
    /// - Parameter registrable: a UITableViewNibRegistrable object.
    public func register(registrable: UITableViewNibRegistrable) {
        guard !cellIdentifiers.contains(registrable.cellReuseIdentifier) else { return }
        
        tableView.register(registrable: registrable)
        cellIdentifiers.insert(registrable.cellReuseIdentifier)
    }
    
    /// Registers an array of UITableViewNibRegistrable objects if not already registered.
    ///
    /// - Parameter registrables: an array of UITableViewNibRegistrable objects.
    public func register(registrables: [UITableViewNibRegistrable]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
    
    // MARK: - UITableViewHeaderFooterNibRegistrable
    
    /// Register a UITableViewHeaderFooterNibRegistrable object if not already registered.
    ///
    /// - Parameter registrable: a UITableViewHeaderFooterNibRegistrable object.
    public func register(registrable: UITableViewHeaderFooterNibRegistrable) {
        guard !headerFooterViewIdentifiers.contains(registrable.viewReuseIdentifier) else { return }
        
        tableView.register(registrable: registrable)
        headerFooterViewIdentifiers.insert(registrable.viewReuseIdentifier)
    }
    
    /// Registers an array of UITableViewHeaderFooterNibRegistrable objects if not already registered.
    ///
    /// - Parameter registrables: an array of UITableViewHeaderFooterNibRegistrable objects.
    public func register(registrables: [UITableViewHeaderFooterNibRegistrable]) {
        registrables.forEach {
            self.register(registrable: $0)
        }
    }
}
