//
//  InputTodoViewController.swift
//  MyApp2
//
//  Created by 보경 on 2023/09/01.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func willDismiss()
}

class InputTodoViewController: UIViewController, UITextFieldDelegate  {
    
    weak var delegate: AddViewControllerDelegate?
    var tempData:[String:String] = [:]

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var categoryBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCategoryMenu()
    }
    
    // 취소 버튼
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // 저장 버튼
    @IBAction func save(_ sender: Any) {
        var todoData = defaults.dictionary(forKey: "todoData") ?? data.todoData
        
        // 텍스트 필드가 비었을 때
        guard textfield.text != nil else {
            return print("할 일에 대한 입력값이 없으므로 저장되지 않았습니다")
        }
        // 텍스트 필드 값을 임시 dictionary 값에 저장
        tempData.updateValue(textfield.text!, forKey: "textfield")
        
        // 카테고리 메뉴 선택 없을 때
        if tempData["category"] == nil {
            return print("카테고리값이 없으므로 저장되지 않았습니다")
        }
        // 카테고리 선택 값 저장
        let category = tempData["category"]!
        
        // 이전 tableview storyboardID instance
        let todoViewControllerID = UIStoryboard(name: "Main", bundle: .none).instantiateViewController(identifier: "todoViewControllerID") as! TodoViewController
        
        // 카테고리는 있으나 기본 할 일 배열은 없었을 경우
        if todoData[category] == nil {
            let array:[String] = [tempData["textfield"]!]
            todoData.updateValue(array, forKey: category)
            defaults.set(todoData, forKey: "todoData")
            self.delegate?.willDismiss()

            return self.dismiss(animated: true, completion: { todoViewControllerID.tableView?.reloadData()} )
        }
        // 기본 할 일 배열에 데이터 추가
        var array = todoData[category] as! [String]
        array.append(tempData["textfield"]!)
        todoData.updateValue(array, forKey: category)
        defaults.set(todoData, forKey: "todoData")
        self.delegate?.willDismiss()
            return self.dismiss(animated: true, completion: { todoViewControllerID.tableView?.reloadData()} )
        }
    
    // 카테고리 선택 메뉴 버튼
    func drawCategoryMenu() {
        // 카테고리 배열 불러오기
        let categories = defaults.array(forKey: "category") ?? data.category
        
        // UIAcion 배열 생성
        var menuItems:[UIAction] = []
        for category in categories {
            menuItems.append(UIAction(title: category as! String, image: nil, handler: { _ in self.tempData["category"] = category as? String
                self.categoryBtn.setTitle(category as? String, for: .normal)
            }
        ))}
        
        // UIMenu에 UIAction 배열 연결
        let menu = UIMenu(title: "할 일의 카테고리 선택", options: .displayInline, children: menuItems)
        
        categoryBtn.setTitle("🔎 카테고리 선택", for: .normal)
        categoryBtn.menu = menu
        categoryBtn.showsMenuAsPrimaryAction = true
    }
}
