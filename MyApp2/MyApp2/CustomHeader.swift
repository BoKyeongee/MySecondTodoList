//
//  CustomHeader.swift
//  MyApp2
//
//  Created by 보경 on 2023/08/30.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {

    let title = UILabel()
    let emoji = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        emoji.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(emoji)
        contentView.addSubview(title)
        

        NSLayoutConstraint.activate([
            emoji.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            emoji.widthAnchor.constraint(equalToConstant: 30),
            emoji.heightAnchor.constraint(equalToConstant: 30),
            emoji.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: emoji.trailingAnchor,
                                           constant: 8),
            title.trailingAnchor.constraint(equalTo:
                                                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
