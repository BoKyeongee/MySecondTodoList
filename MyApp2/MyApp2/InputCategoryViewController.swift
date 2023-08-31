//
//  InputCategoryViewController.swift
//  MyApp2
//
//  Created by 보경 on 2023/09/01.
//

import UIKit
import EmojiPicker

class InputCategoryViewController: UIViewController {

    @IBOutlet weak var emojiPickButton: UIButton!
    @IBOutlet weak var textfield: UITextField!
    
    var tempData:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emojiPickButton)
        
        emojiPickButton.setTitle("😃", for: .normal)
        emojiPickButton.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        emojiPickButton.addTarget(self, action: #selector(openEmojiPickerModule), for: .touchUpInside)
        print(emojiPickButton.titleLabel?.text as Any)
    }
    
    @objc private func openEmojiPickerModule(sender: UIButton) {
        let viewController = EmojiPickerViewController()
        viewController.sourceView = sender
        viewController.delegate = self
        
        /// # Optional parameters
        viewController.selectedEmojiCategoryTintColor = .systemRed
        viewController.arrowDirection = .up
        viewController.horizontalInset = 16
        viewController.isDismissedAfterChoosing = true
        viewController.customHeight = 200
        viewController.feedbackGeneratorStyle = .soft
        
        present(viewController, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        var category = defaults.array(forKey: "category") ?? data.category
        var emoji = defaults.array(forKey: "emoji") ?? data.emoji
        
        guard textfield.text != nil else
        { return print("입력값이 없습니다")}
        tempData.updateValue(textfield.text!, forKey: "textfield")
        
        category.append(tempData["textfield"])
        emoji.append(tempData["emoji"])
        
        defaults.set(category, forKey: "category")
        defaults.set(emoji, forKey: "emoji")
        
        print(defaults.array(forKey: "category")!)
        print(defaults.array(forKey: "emoji")!)
        
        self.dismiss(animated: true)
    }
}

extension InputCategoryViewController: EmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiPickButton.setTitle(emoji, for: .normal)
        tempData.updateValue(emoji, forKey: "emoji")
    }
}
