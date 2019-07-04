//
//  ContactsViewController.swift
//  WeChatSwift
//
//  Created by xu.shuifeng on 2019/7/4.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var dataSource: [ContactSection] = []
    
    private lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage.SVGImage(named: "icons_outlined_addfriends"), style: .done, target: self, action: #selector(handleRightBarButtonTapped(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backgroundColor
        
        setupTableView()
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.navigationItem.rightBarButtonItem = rightButtonItem
        tabBarController?.navigationItem.title = "通讯录"
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactViewCell.self, forCellReuseIdentifier: NSStringFromClass(ContactViewCell.self))
//        tableView.sectionIndexColor = .gray
//        tableView.sectionIndexBackgroundColor = .clear
//        tableView.sectionIndexTrackingBackgroundColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        view.addSubview(tableView)
    }
    
    private func setupDataSource() {
        let searchSection = ContactSection(title: "🔍", models: [.newFriends, .groupChats, .tags, .officialAccounts])
        dataSource.append(searchSection)
    }
    
}

// MARK: - Event Handlers
extension ContactsViewController {
    
    @objc private func handleRightBarButtonTapped(_ sender: Any) {
        let controller = AddContactViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ContactViewCell.self), for: indexPath) as! ContactViewCell
        let model = dataSource[indexPath.section].models[indexPath.row]
        cell.update(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return dataSource.map { return $0.title }
//    }
}