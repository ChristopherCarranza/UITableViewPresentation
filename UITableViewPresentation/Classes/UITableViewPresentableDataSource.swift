//
//  UITableViewPresentableDataSource.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UIKit
import Dwifft

public protocol UITableViewPresentableDataSourceDelegate: class {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, presentable: AnyUITableViewPresentable)
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public extension UITableViewPresentableDataSourceDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

/// An object for coordinating data between a `UITableViewModel` and a `UITableView`.
/// If the `UITableViewPresentable` objects used in the model conform to
/// `UITableViewNibRegistrable` then registration with the table view is automatic, if
/// not table cells must be registered manually.
public final class UITableViewPresentableDataSource: NSObject {
    fileprivate weak var tableView: UITableView!
    fileprivate let tableViewRegistrar: UITableViewRegistrar
    
    private var _tableViewModel: UITableViewModel = []
    
    /// The `UITableViewModel` used in the datasource. Setting this property will cause the model to change without animation.
    public var tableViewModel: UITableViewModel {
        get { return _tableViewModel }
        set { setTableViewModel(to: newValue) }
    }
    
    public weak var delegate: UITableViewPresentableDataSourceDelegate?
    
    public init(tableView: UITableView, delegate: UITableViewPresentableDataSourceDelegate? = nil, tableViewModel: UITableViewModel = []) {
        self.tableView = tableView
        self.tableViewRegistrar = UITableViewRegistrar(tableView: tableView)
        self.delegate = delegate
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        setTableViewModel(to: tableViewModel)
    }
    
    /// Sets the new model and reloads the table view. If animated a diff occures between the
    /// previous model and the new model and the corresponding changes to the table view are
    /// animated. Animations are determined by the `insertionAnimation` and `deletionAnimation`
    /// properties.
    ///
    /// - Parameters:
    ///   - model: a `UITableViewModel` object
    ///   - animated: If `true` model changes are animated.
    public func setTableViewModel(to newModel: UITableViewModel, animated: Bool = false) {
        guard newModel != _tableViewModel else { return }
        
        tableViewRegistrar.register(tableViewModel: newModel)
        
        guard animated else {
            _tableViewModel = newModel
            tableView.reloadData()
            return
        }
        
        let oldModel = _tableViewModel
        let diff = Dwifft.diff(lhs: oldModel, rhs: newModel)
        if !diff.isEmpty {
            processChanges(newState: newModel, diff: diff)
        }
    }
    
    /// You can change insertion/deletion animations like this! Fade works well.
    /// So does Top/Bottom. Left/Right/Middle are a little weird, but hey, do your thing.
    public var insertionAnimation: UITableView.RowAnimation = .automatic,
                deletionAnimation: UITableView.RowAnimation = .automatic
    
    fileprivate func processChanges(newState: UITableViewModel, diff: [SectionedDiffStep<Dwifft.UITableViewSectionDiffModel, AnyUITableViewPresentable>]) {
        guard let tableView = self.tableView else { return }
        let performUpdates = {
            for result in diff {
                switch result {
                case let .delete(section, row, _): tableView.deleteRows(at: [IndexPath(row: row, section: section)], with: self.deletionAnimation)
                case let .insert(section, row, _): tableView.insertRows(at: [IndexPath(row: row, section: section)], with: self.insertionAnimation)
                case let .sectionDelete(section, _): tableView.deleteSections(IndexSet(integer: section), with: self.deletionAnimation)
                case let .sectionInsert(section, _): tableView.insertSections(IndexSet(integer: section), with: self.insertionAnimation)
                }
            }
        }
        
        if #available(iOS 11.0, *) {
            _tableViewModel = newState
            tableView.performBatchUpdates(performUpdates, completion: nil)
        } else {
            tableView.beginUpdates()
            _tableViewModel = newState
            performUpdates()
            tableView.endUpdates()
        }
    }
}

extension UITableViewPresentableDataSource: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel[section].count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard case .title(let title) = tableViewModel[section].header else { return nil }
        
        return title
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard case .title(let title) = tableViewModel[section].footer else { return nil }
        
        return title
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // NOTE: Making the assumption here that the cell has been registered, if we haven't we probably want to crash
        let cell = tableView.dequeReusableCell(presentable: tableViewModel[indexPath], for: indexPath)!
        tableViewModel[indexPath].configure(cell: cell, at: indexPath)
        return cell
    }
}

extension UITableViewPresentableDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard case .presentable(let presentable) = tableViewModel[section].header else { return nil }
        
        // NOTE: Making the assumption here that the view has been registered, if we haven't we probably want to crash
        let headerView = tableView.dequeReusableHeaderFooterView(presentable: presentable)!
        presentable.configure(view: headerView, for: section)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableViewModel[section].header {
        case .presentable, .title:
            return UITableView.automaticDimension
        case .blank:
            // Returning this value will make the tableview draw an "invisible" header
            // essentially truncating the tableviews default behavior of repeating
            // row separators past the last row.
            return 0.01
        case .none:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard case .presentable(let presentable) = tableViewModel[section].footer else { return nil }
        
        // NOTE: Making the assumption here that the view has been registered, if we haven't we probably want to crash
        let footerView = tableView.dequeReusableHeaderFooterView(presentable: presentable)!
        presentable.configure(view: footerView, for: section)
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch tableViewModel[section].footer {
        case .presentable, .title:
            return UITableView.automaticDimension
        case .blank:
            // Returning this value will make the tableview draw an "invisible" footer
            // essentially truncating the tableviews default behavior of repeating
            // row separators past the last row.
            return 0.01
        case .none:
            return 0
        }
    }
    
    // MARK: - Passthrough
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView(tableView, didSelectRowAt: indexPath, presentable: tableViewModel[indexPath])
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}