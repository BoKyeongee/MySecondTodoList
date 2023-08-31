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
    weak var delegate:UITextFieldDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "해야할 일"
    }
    
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
        
        // Userdefaults 기본값 세팅
        let defaultSettings = ["todoData": data.todoData, "category": data.category] as [String : Any]
        defaults.register(defaults: defaultSettings)
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
        view.title.text = category[section] as? String
        view.button.setImage(UIImage(systemName: "plus"), for: .normal)
        view.button.addTarget(self, action: #selector(clickPlus), for: .touchUpInside)
        view.contentView.backgroundColor = .secondarySystemBackground
        
        return view
    }

    // section header 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // cell 선택 시 편집 되도록 변경해야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoViewControllerCell

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
        print(countArray)
        return countArray[section]
    }
    
    // cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoViewControllerCell
        
        let categories = defaults.array(forKey: "category") ?? data.category
        let category = categories[indexPath.section]
        let todoData = defaults.dictionary(forKey: "todoData") as? [String:[String]] ?? data.todoData
        
        var cellArray = todoData[category as? String ?? data.category[indexPath.section]]
        
        cell.todoLabel.text = (cellArray?[indexPath.row])! as String
        cell.checkBox.isEnabled = true
                
        return cell
    }
    
    // cell 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func checkBox(_ sender: Any) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TodoViewControllerCell
        cell.checkBox.isSelected = true
        cell.checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        cell.checkBox.isSelected.toggle()
    }
    
    @objc func clickPlus(_ sectionIndex: Int) {
        let categories = defaults.array(forKey: "category") ?? data.category
        let key = categories[sectionIndex] as! String
    }
}

extension TodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField, _  cellArray: [String], _ row: Int) -> [String] {
      if textField != nil {
          var newArray = cellArray
          newArray[row] = textField.text ?? cellArray[row]
          return newArray
      }
    return cellArray
  }
}
