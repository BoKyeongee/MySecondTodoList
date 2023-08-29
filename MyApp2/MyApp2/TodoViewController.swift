//
//  TodoViewController.swift
//  MyApp2
//
//  Created by 남보경 on 2023/08/03.
//

import UIKit


let defaults = UserDefaults.standard
let data = Data.shared

class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        // header of footer 등록
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        
        // Userdefaults 기본값 세팅
        let defaultSettings = ["todoData": data.todoData,"doneData":data.doneData]
        defaults.register(defaults: defaultSettings)
        
        // 테이블뷰 delegate
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // section 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        let category = getDictKey()
        print("category: \(category)")
        return category.count
    }
    
    // section header 반환
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        
        let headerView = CustomHeaderView(reuseIdentifier: "customHeader")
        
        let category = getDictKey()
        
        headerView.categoryLabel.text = category[section]
        headerView.addBtn.isEnabled = true
        
        return header
    }

    // section header 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // cell 선택 시 편집 되도록 변경해야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        defaults.set(index, forKey: "current")
    }

    // cell 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let category = getDictKey()
        var countArray = [Int]()
        
        for value in category {
            let array = getArray(value)
            countArray.append(array?.count ?? 0)
        }
        print(countArray.count)
        return countArray[section]
    }
    
    // cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoViewControllerCell
        
        let category = getDictKey()
        let forKey = category[indexPath.section]
        let taskArray = getArray(forKey)
        print("할 일: \(taskArray)")
        
        cell.todo.text? = taskArray![indexPath.row] as! String
        cell.checkBox.isEnabled = true
        
        return cell
    }
    
    // cell 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func checkBox(_ sender: Any) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TodoViewControllerCell
        cell.checkBox.isSelected = true
        cell.checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        cell.checkBox.isSelected.toggle()
    }
    
    // UserDefaults array 가져오기
    // category명이 forKey명
    func getArray(_ forKey:String) -> [Any]? {
        let array = defaults.array(forKey: forKey) ?? data.doneData[forKey]
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
    
    // dummy data는 항상 set
    func setDefaults() {
        let category = getDictKey()
        let dictionary = getDict()
        
        for value in category {
            defaults.set(dictionary?[value], forKey: value)
        }
        return
    }
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
