//
//  ViewController.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import UIKit
import Intents

private enum Constants: String {
    case cellID = "ListItemCell"
}

class ViewController: UIViewController {

    fileprivate var items: [ListDisplayable]?
    var dataProvider: ListDisplayableDataProvider = MoviesManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRefreshControl()
        self.requestSiriAuthorization()
        
        self.reloadData()
    }
    
    private func setupRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(ViewController.refreshControlAction), for: UIControl.Event.valueChanged)
    }
    
    private func requestSiriAuthorization() {
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .authorized:
                print("authorized")
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            @unknown default:
                print("can't see into the future... yet")
            }
        }
    }
    
    @objc func refreshControlAction() {
        self.reloadData()
    }
    
    private func reloadData() {
        self.tableView.refreshControl?.beginRefreshing()
        dataProvider.getListItems { (items) in
            self.tableView.refreshControl?.endRefreshing()
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    @IBAction private func clearAllData() {
        self.items = nil
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.rawValue)
        
        if let cellItem = items?[indexPath.row] {
            cell?.textLabel?.text = cellItem.listItemTitle
            cell?.detailTextLabel?.text = cellItem.listItemSubtitle
        }
        
        return cell!
    }
}

// MARK: Just for testing
extension ViewController {
    
    // This method is not part of the pattern, we'll use it for testing only
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        guard let moviesManager = dataProvider as? MoviesManager else {
            return
        }
        
        if sender.selectedSegmentIndex == 1 {
            moviesManager.moviesDataProvider = MoviesDataSource()
            moviesManager.moviesDataProvider.networkingProvider = NSURLNetworkConnector()
        } else if sender.selectedSegmentIndex == 2 {
            moviesManager.moviesDataProvider = MoviesDataSource_Operations()
        }
    }
}
