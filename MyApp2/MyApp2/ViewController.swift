//
//  ViewController.swift
//  MyApp2
//
//  Created by 남보경 on 2023/08/03.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBAction func segueNavAct(_ sender: UIButton) {

    }
    @IBOutlet weak var mainImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigaiton back 버튼 검정색 뒤로가기로 변경
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
                    backBarButtonItem.tintColor = .black
        
        // mainImg에 사용할 URL
        let imageUrl = "https://i.ibb.co/QMVpNXC/todo-main-img.png"
        
        // Alamofire를 사용한 이미지 로드
        AF.request(imageUrl).response { response in
            switch response.result {
                
                // 이미지 로드 성공 시
                case.success(let data):
                    print("이미지 로드 성공")
                    DispatchQueue.main.async {
                        self.mainImg.image = UIImage(data: data!)
                    }
                    
                // 이미지 로드 실패 시
                case.failure(let error):
                    print("이미지 로드에 실패하여 기본 이미지를 뷰에 연결합니다")
                    print("에러: \(error)")
                    self.mainImg.image = UIImage(named: "basic_profile_img")
                }
        }
        // view 구조
        view.addSubview(mainImg)
    }
}
