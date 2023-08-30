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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        // header of footer 등록
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        // 테이블뷰 delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Userdefaults 기본값 세팅
        let defaultSettings = ["todoData": data.todoData, "고양이 돌보기": ["힘들어도 놀아주기", "궁디팡팡 해주기"], "공부": ["TIL 작성하기"]] as [String : Any]
        defaults.register(defaults: defaultSettings)
    }
    
    // section 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        let category = getDictKey()
        return category.count
    }
    
    // section header 반환
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! CustomHeader
        let category = getDictKey()
        view.title.text = category[section]
        view.button.setImage(UIImage(systemName: "plus"), for: .normal)

        return view
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
        
        let categories = getDictKey()
        var countArray = [Int]()
        
        for category in categories {
            let array = getArray(category)
            countArray.append(array?.count ?? 0)
        }
        print(countArray)
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
    
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
