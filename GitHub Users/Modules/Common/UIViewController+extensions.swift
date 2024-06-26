//
//  UIViewController+extensions.swift
//  GitHub Users
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

extension UIViewController {
    func dequeueLoadingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: LoadingTableViewCell.reuseIdentifier,
            for: indexPath
        )
        cell.selectionStyle = .none
        return cell
    }

    func dequeueErrorCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(
            withIdentifier: ErrorTableViewCell.reuseIdentifier,
            for: indexPath
        )
    }
}
