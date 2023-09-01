# MySecondTodoList

## MVC Architecture

Data.swift 파일에 dummy data를 생성
싱글톤 패턴으로 접근할 수 있도록 static 인스턴스 및 private init() 선언
section의 header(task의 카테고리)는 dictionary의 key 값이고 해당 section의 cell에 해당하는 할 일들은 value값으로 `[String]`값
딕셔너리로만 관리시에 순서가 매번 바뀌는 번거로움이 있어 배열로 따로 `category`와 `emoji`를 관리

해당 Model을 TableViewController의 Dalegate와 DataSource를 위임받은 ViewController를 사용
TableViewCell의 label과 dataSource의 section header에 설정함으로써 view와 데이터를 연결

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

## 기능

**1. launch screen 추가**
**2. main 화면 URLSession() 이용한 이미지 로딩**
**3. todo list의 costom header**
카테고리를 추가할 때 고른 이모지를 아이콘으로 설정할 수 있으며, 이것이 같이 section header에 출력되는 custom header
**4. emojiPicker packages를 이용한 카테고리 및 아이콘(이모지 이용)추가 기능**
**5. pulldown menu를 활용한 카테고리 선택 및 할 일 목록 생성**
