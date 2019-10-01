//
//  ViewController.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit
import UITableViewPresentation

final class ViewController: UIViewController {
    private enum TestModel {
        case one
        case two
    }

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource: UITableViewPresentableDataSource!
    
    private var currentModel: TestModel = .one
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UITableViewPresentableDataSource(tableView: tableView, delegate: self)

        dataSource.setTableViewModel(to: ModelHelper.testModelOne(delegate: self), animated: false)
    }

    @IBAction func swapModelButtonTapped(_ sender: UIBarButtonItem) {
        let model: UITableViewModel
        if currentModel == .one {
            currentModel = .two
            model = ModelHelper.testModelTwo(delegate: self)
        } else {
            currentModel = .one
            model = ModelHelper.testModelOne(delegate: self)
        }
        
        dataSource.setTableViewModel(to: model, animated: true)
    }
}

extension ViewController: UITableViewPresentableDataSourceDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, presentable: AnyUITableViewPresentable) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Row tapped")
    }
}

extension ViewController: ExampleActionDelegate {
    func takeAction() {
        let actionSheet = UIAlertController(title: "Example", message: "Choose an action", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Example 1", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Example 2", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
}
