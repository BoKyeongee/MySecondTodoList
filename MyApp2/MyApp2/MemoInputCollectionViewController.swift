//
//  MemoInputCollectionViewController.swift
//  MyApp2
//
//  Created by 남보경 on 2023/09/01.
//

import UIKit

class MemoInputCollectionViewController: UICollectionViewController {

    @IBOutlet var emojiCollectionView: UICollectionView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emojiCollectionView)
        view.addSubview(textField)
        
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        emojiCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        if let flowlayout = emojiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {flowlayout.estimatedItemSize = .zero}
        emojiCollectionView.contentInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let interItemSpacing: CGFloat = 10
    let width = (collectionView.bounds.width - interItemSpacing * 3) / 2
    let height = width
    return CGSize(width: width, height: height)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaults.array(forKey: "emoji")?.count ?? data.emoji.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = emojiCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MemoInputCollectionViewCell else {
                        return UICollectionViewCell()
        }
        let emojiArray = defaults.array(forKey: "emoji") ?? data.emoji
        cell.emoji.text = emojiArray[indexPath.item] as? String
        return cell
    }

}
