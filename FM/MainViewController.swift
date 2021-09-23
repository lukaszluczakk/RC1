//
//  TasksViewController.swift
//  FM
//
//  Created by Łukasz Łuczak on 31/08/2021.
//

import UIKit

class MainViewController: UIViewController,  UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var dataSource: DataSourceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureIndicatorView()
        configureTableView()
        firstLoadTableData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let webViewController = segue.destination as! WebViewController
            let selectedItem = dataSource.item(at: selectedRow)
            webViewController.dataItem = selectedItem
        }
    }
}

extension MainViewController {
    func configureIndicatorView() {
        indicatorView.accessibilityIdentifier = "MainIndicator"
    }
    
    func configureTableView(){
        tableView.accessibilityIdentifier = "MainTable"
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(up), for: .valueChanged)
        tableView.delegate = self
        let api = RecruitmentTaskApiFactory.getInstance()
        let apiAdapter = RecruitmentTaskApiAdapter(api: api)
        dataSource = DataSource(apiAdapter: apiAdapter)
        tableView.dataSource = dataSource
    }
    
    @objc private func up(){
        reloadData()
    }
    
    func firstLoadTableData() {
        indicatorView.startAnimating()
        tableView.isHidden = true
        dataSource.loadData {
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    func reloadData() {
        dataSource.loadData() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}
