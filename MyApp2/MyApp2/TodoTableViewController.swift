//
//  TodoViewController.swift
//  MyApp2
//
//  Created by 남보경 on 2023/08/03.
//

import UIKit
import SwiftUI

let defaults = UserDefaults.standard
let data = Data.shared

class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: AddViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        delegate?.willDismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        delegate?.willDismiss()
        
        // 상단 공백 없애기
        tableView.sectionHeaderTopPadding = 0
        
        // header of footer 등록
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        // 테이블뷰 delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Userdefaults 기본값 세팅
        let defaultSettings = ["todoData": data.todoData, "category": data.category] as [String : Any]
        defaults.register(defaults: defaultSettings)
    }
    
    // 왼쪽으로 swipe하면 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제", handler: { action, view, completionHaldler in
            let categories = defaults.array(forKey: "category") ?? data.category
            let category = categories[indexPath.section] as! String
            
            var todoData = defaults.dictionary(forKey: "todoData") as? [String:[String]] ?? data.todoData
            
            var cellArray = todoData[category] ?? data.todoData[category]
            let cellData = cellArray?[indexPath.row]
            cellArray?.remove(at: indexPath.row)
            
            if cellArray != nil {todoData.updateValue(cellArray!, forKey: category)}
            else {todoData.removeValue(forKey: category )}
                completionHaldler(true)
            defaults.set(todoData, forKey: "todoData")
            
            tableView.reloadData()
            })
        
            return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // section 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return defaults.array(forKey: "category")?.count ?? data.category.count
    }
    
    // section header 반환
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if ((tableView.dataSource?.tableView(tableView, numberOfRowsInSection:section)) == 0) {
            return nil;
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! CustomHeader
        let category = defaults.array(forKey: "category") ?? data.category
        let emoji = defaults.array(forKey: "emoji") ?? data.emoji
        
        view.title.text = category[section] as? String
        view.emoji.text = emoji[section] as? String
        view.contentView.backgroundColor = .secondarySystemBackground
        
        return view
    }

    // section header 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    // cell 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = defaults.array(forKey: "category") ?? data.category
        var countArray = [Int]()
        
        for category in categories {
            let dictionary = defaults.dictionary(forKey: "todoData") as? [String:[String]] ?? data.todoData
            let array = dictionary[category as? String ?? data.category[section]]
            countArray.append(array?.count ?? 0)
        }
        return countArray[section]
    }
    
    // cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoViewControllerCell
        
        let categories = defaults.array(forKey: "category") ?? data.category
        let category = categories[indexPath.section]
        let todoData = defaults.dictionary(forKey: "todoData") as? [String:[String]] ?? data.todoData
        
        let cellArray = todoData[category as? String ?? data.category[indexPath.section]]
        
        cell.todoLabel.text = (cellArray?[indexPath.row])! as String
        cell.checkBox.isEnabled = true
                
        return cell
    }
    
    // cell 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func addTask(_ sender: Any) {
        let inputTodoViewControllerID = UIStoryboard(name: "Main", bundle: .none).instantiateViewController(identifier: "inputTodoViewControllerID") as! InputTodoViewController
        inputTodoViewControllerID.delegate = self
    }
    
    // 오류 발생
//    @IBAction func checkBoxAct(_ sender: Any, _ indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TodoViewControllerCell
//        cell.checkBox.addTarget(self, action: #selector(sendToDone), for: .touchUpInside)
//    }
//    
//    @objc func sendToDone(_ sender: Any, _ indexPath: IndexPath) {
//        let categories = defaults.array(forKey: "category") ?? data.category
//        let category = categories[indexPath.section] as! String
//        
//        var todoData = defaults.dictionary(forKey: "todoData") as? [String:[String]] ?? data.todoData
//        var doneData = defaults.dictionary(forKey: "doneData") as? [String:[String]] ?? data.doneData
//        
//        var todoCellArray = todoData[category] ?? data.todoData[category]
//        var doneCellArray = doneData[category] ?? data.doneData[category]
//        
//        if doneCellArray != nil {
//            doneData.updateValue([todoCellArray![indexPath.row]], forKey: category)
//            defaults.set(doneData, forKey: "doneData")
//        }
//        else {
//            doneCellArray?.append(todoCellArray![indexPath.row])
//            doneData.updateValue(doneCellArray!, forKey: "doneData")
//            defaults.set(todoData, forKey: "todoData")
//        }
//        let cellData = todoCellArray?[indexPath.row]
//        todoCellArray?.remove(at: indexPath.row)
//        
//        if todoCellArray != nil {todoData.updateValue(todoCellArray!, forKey: category)}
//        else {todoData.removeValue(forKey: category)}
//        defaults.set(todoData, forKey: "todoData")
//    }
}

extension TodoViewController: AddViewControllerDelegate {
    func willDismiss() {
        tableView.reloadData()
    }
}
