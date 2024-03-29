# MySecondTodoList

## MVC Architecture

Data.swift 파일에 dummy data를 생성<br>
싱글톤 패턴으로 접근할 수 있도록 static 인스턴스 및 private init() 선언<br>
section의 header(task의 카테고리)는 dictionary의 key 값이고 해당 section의 cell에 해당하는 할 일들은 value값으로 `[String]`값<br>
딕셔너리로만 관리시에 순서가 매번 바뀌는 번거로움이 있어 배열로 따로 `category`와 `emoji`를 관리<br><br>

해당 Model을 TableViewController의 Dalegate와 DataSource를 위임받은 ViewController를 사용<br>
TableViewCell의 label과 dataSource의 section header에 설정함으로써 view와 데이터를 연결<br>
modal로 present되어 잠시 정보를 담는 tempData dictionary([String:String]) 형태를 제외하고 UserDefaults를 사용해서 일정한 데이터 유지<br><br>

```swift
class Data {
    static let shared = Data()

    private init() {}
    
    var todoData: [String:[String]] = ["고양이 돌보기":["힘들어도 놀아주기", "궁디팡팡 해주기"], "공부":["TIL 작성하기"]]
    var doneData: [String:[String]] = ["공부":["내배캠 출석체크"], "집안일":["방 치우기", "설거지 하기", "음식물 쓰레기 처리하기"]]
    var category:[String] = ["고양이 돌보기", "공부", "집안일"]
    var emoji = ["😻", "📝", "🧽"]
}

```
<br><br>
## 기능<br>

**1. launch screen 추가**<br>
**2. main 화면 URLSession() 이용한 이미지 로딩**<br>
**3. todo list의 costom header**<br>
카테고리를 추가할 때 고른 이모지를 아이콘으로 설정할 수 있으며, 이것이 같이 section header에 출력되는 custom header<br>
**4. emojiPicker packages를 이용한 카테고리 및 아이콘(이모지 이용)추가 기능**<br>
**5. pulldown menu를 활용한 카테고리 선택 및 할 일 목록 생성**<br>
**6. UserDefaults로 CRUD 구현**<br>
- 할 일 추가 및 카테고리 추가 가능.<br>
- 할 일추가 시 tableView에서 해당 데이터를 불러올 수 있고 업데이트 된 데이터를 반영할 수 있음.<br>
- 카테고리 추가 시 sectionHeader에서 해당 데이터를 불러오고 업데이트 된 데이터를 반영할 수 있음.<br>
- delete의 경우 cell을 우측에서 좌측으로 swipe할 경우 delete 가능.<br>
