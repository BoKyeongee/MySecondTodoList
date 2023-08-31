//
//  DoneViewController.swift
//  MyApp2
//
//  Created by 보경 on 2023/08/30.
//

import UIKit

class DoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        // 상단 공백 없애기
        tableView.sectionHeaderTopPadding = 0
                
        // header of footer 등록
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        // 테이블뷰 delegate
        tableView.delegate = self
        tableView.dataSource = self

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
        
        view.contentView.backgroundColor = .secondarySystemBackground
        view.title.text = category[section] as? String
        view.button.setImage(UIImage(systemName: "plus"), for: .normal)
        view.button.addTarget(self, action: #selector(clickPlus), for: .touchUpInside)
        return view
    }

    // section header 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if ((tableView.dataSource?.tableView(tableView, numberOfRowsInSection:section)) == 0) {
            return 0;
        }
        return 30
    }
    
    // cell 선택 시 편집 되도록 변경해야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        defaults.set(index, forKey: "current")
    }

    // cell 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = defaults.array(forKey: "category") ?? data.category
        var countArray = [Int]()
        
        for category in categories {
            let dictionary = defaults.dictionary(forKey: "doneData") as? [String:[String]] ?? data.doneData
            let array = dictionary[category as? String ?? data.category[section]]
            countArray.append(array?.count ?? 0)
        }
        print(countArray)
        return countArray[section]
    }
    
    // cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoneTableViewCell
        
        let categories = defaults.array(forKey: "category") ?? data.category
        let category = categories[indexPath.section]
        let doneData = defaults.dictionary(forKey: "doneData") as? [String:[String]] ?? data.doneData
        
        let cellArray = doneData[category as? String ?? data.category[indexPath.section]]
        
        cell.doneField.text = (cellArray?[indexPath.row])! as String
        cell.doneField.borderStyle = .none
        cell.checkedBox.isEnabled = true
        
        return cell
    }
    
    // cell 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // UserDefaults array 가져오기
    // category명이 forKey명
    func getArray(_ forKey:String) -> [Any]? {
        let array = defaults.array(forKey: forKey)
        return array
    }
    
    // UserDefaults Dictionary 가져오기
    // todoData or doneData만 forKey로 가능
    func getDict() -> [String:Any]? {
        let dictionary = defaults.dictionary(forKey: "todoData")
        return dictionary
    }
    
    // Dictionary에서 key(category)만 반환
    func getDictKey() -> [String] {
        var result = [String]()
        let dictionary = defaults.dictionary(forKey: "todoData")
        for (key, _) in dictionary! {
            result.append(key)
        }
        return result
    }
    
    // nil일 경우 defaults값 set
    func setDefaults() {
        let categories = getDictKey()
        
        for category in categories {
            if getArray(category) == nil {
                defaults.set(data.todoData[category], forKey: "category")
            }
        }
    }
    
    @objc func clickPlus(_ sectionIndex: Int) {
        let categories = defaults.array(forKey: "category") ?? data.category
        let key = categories[sectionIndex] as! String
    }
    
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
