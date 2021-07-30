//
//  ActivityTableViewCell.swift
//  ReditApp
//
//  Created by Riley Calkins on 7/25/21.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    let cellIdentifier = "ActivityTableViewCell"
    private let activityView = UIRefreshControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {
        contentView.addSubview(activityView)
        activityView.beginRefreshing()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

}
