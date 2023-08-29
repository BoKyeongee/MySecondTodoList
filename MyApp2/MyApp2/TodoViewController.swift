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
        
        // Userdefaults 기본값 세팅
        let defaultSettings = ["todo": data.todo, "todoDone": data.todoDone, "routine": data.routine, "routineDone": data.routineDone] as [String : Any]
        defaults.register(defaults: defaultSettings)
        
        // 테이블뷰 delegate
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // section 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {2}
    
    // section header title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitles = ["오늘 할 일", "루틴"]
        
       return sectionTitles[section]
    }

    // section header 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // cell 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        defaults.set(index, forKey: "current")
    }

    // cell 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return getArray("todo")?.count ?? data.todo.count
        case 1 : return getArray("routine")?.count ?? data.routine.count
        default: return 1
        }
    }
    
    // cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoViewControllerCell
        switch indexPath.section {
        case 0 :
            let todo = getArray("todo") ?? data.todo
            if todo.isEmpty != true {
                cell.todo.text = todo[indexPath.row] as? String
            }
            else if todo.isEmpty == true {
                cell.todo.text = "오늘 할 일을 다 하셨어요!🔥"
            }
            return cell
        case 1 :
            let routine = getArray("routine") ?? data.routine
            if routine.isEmpty != true {
                cell.todo.text = routine[indexPath.row] as? String
            }
            else if routine.isEmpty == true {
                cell.todo.text = "오늘 할 일을 다 하셨어요!🔥"
            }
            return cell
        default: return cell
        }
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
    func getArray(_ forKey: String) -> [Any]? {
        let array = defaults.array(forKey: forKey)
        return array
    }
    
    
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
