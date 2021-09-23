//
//  TaskListDataSource.swift
//  FM
//
//  Created by Łukasz Łuczak on 31/08/2021.
//

import UIKit

protocol DataSourceProtocol: UITableViewDataSource {
    func loadData(completion: @escaping () -> Void)
    func item(at row: Int) -> DataItemDTO
    func count() -> Int
}

final class DataSource: NSObject, DataSourceProtocol {
    private let apiAdapter: DataApiAdapterProtocol
    private var dataSource: [DataItemDTO] = []

    init(apiAdapter: DataApiAdapterProtocol) {
        self.apiAdapter = apiAdapter
        super.init()
    }
    
    func item(at row: Int) -> DataItemDTO {
        dataSource[row]
    }
    
    func loadData(completion: @escaping () -> Void) {
        apiAdapter.getData { [weak self] returnedItems in
            guard let self = self else { return }
            self.dataSource = returnedItems
            completion()
        }
    }
    
    func count() -> Int {
        dataSource.count
    }
}

extension DataSource: UITableViewDataSource {
    private static let reminderListCellIdentifier = "ListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderListCellIdentifier, for: indexPath) as? ListCell else {
            fatalError("Unable to dequeue TaskCell")
        }
        
        let item = item(at: indexPath.row)
        cell.configure(orderId: item.orderId, title: item.title, description: item.description, imageUrl: item.imageURL, modificationDate: item.modificationDate)

        return cell
    }
}
