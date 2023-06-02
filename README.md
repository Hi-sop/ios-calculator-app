# README

# ✖️➕🧮➖➗ 🟰계산기

## 📖 목차
1. [소개](#-소개)
2. [팀원](#-팀원)
3. [타임라인](#-타임라인)
4. [시각화된 프로젝트 구조](#-시각화된-프로젝트-구조)
5. [실행 화면](#-실행-화면)
6. [트러블 슈팅](#-트러블-슈팅)
7. [참고 링크](#-참고-링크)
8. [팀 회고](#-팀-회고)

---

## 🍀 소개

`Hemg` 이/(가) 만든 계산기 프로젝트 입니다.

- 주요 개념: `protocols` ,  `extensions`, `Error Handling` , `closures` , `advancedoperators`, `inheritance`, `subscripts` 

---

## 👨‍💻 팀원

| Hemg |
| :---: |
|<Img src="https://user-images.githubusercontent.com/101572902/235090676-acefc28d-a358-486b-b9a6-f9c84c52ae9c.jpeg" width="250" height="300"> |
[Github Profile](https://github.com/hemg2)|


## 👀 시각화된 프로젝트 구조

 <Img src="https://github.com/hemg2/ios-calculator-app/assets/101572902/93acdfb4-5f47-4f98-8541-ea01a462deb5" height="300">

## 💻 실행 화면
- 추후 추가 진행하도록하겠습니다.

---

## ⏰ 타임라인 

| 날짜 | 내용 |
| :---: | --- |
| 2023.05.29. | 계산기 구현관련된 자료 검색 및 공부 |
| 2023.05.30. | `CalculatorItemQueue` 객체, `CalculatorTests` 테스트객체 생성, 테스트 진행|
| 2023.05.31. | `Queue` -> `LinkedList` 변경 진행, `CalculatorItemQueue`, `strcut` -> `class`  타입 변경 |
| 2023.06.01. | `PR` 피드백 수정 진행 -> `lastItem()`생성 `enqueue`테스트 진행, `countItem` 생성, `enqueue` 테스트 진행 |
| 2023.06.02. | 피드백 코멘트 작성 및 README 작성 |

---

## 📝 트러블 슈팅

### `Queue` 와 `LinkedList`
- 기존 처음 구현을 Queue타입으로 진행했다가 LinkedList로 전환을 하게 되었습니다.
- 링크드 리스트가 데이터의 삽입, 삭제, 검색 등의 연산에 효율적인 자료구조라고 알게 되어 계산기 프로젝트에서 시간 복잡도에서의 이점을 가질수있다고 생각해서 변경을 하게 되었습니다.
- `enqueue`-> `head`의 값을 확인해보고 nil이라면 `head`에 새로 들어온 노드를 연결해주고, `tail`도 nil일테니 여기에도 새로운 노드를 연결해줍니다. 이미 링크드 리스트에 데이터들이 들어있는 경우는 가장 마지막 노드를 가리키는 `tail` 포인터로 찾아가서 `tail`이 가리키는 노드의 다음노드에 새 노드를 연결해준 뒤, `tail`이 가리키는 노드를 새로운 노드로 변경해줍니다. 무조건 `tail`을 참조해서 새노드를 연결만 해주면 되니 항상 O(1)된다고 생각합니다.
- `dequeue`-> `head`을 업데이트하고 값을 반환하므로, 상수 시간 O(1)으로 동작 된다고 생각 합니다.

|시간 복잡도|enqeue|dequeue|
|:------:|:---:|:---:|
|Array|O(1)|O(n)|
|LinkedList|O(1)|O(1)|

---

## 📚 참고 링크

- [🍎Apple Docs: protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)
- [🍎Apple Docs: extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/)
- [🍎Apple Docs: Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)
- [🍎Apple Docs: closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [🍎Apple Docs: advancedoperators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators/)
- [🍎Apple Docs: inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/)
- [🍎Apple Docs: subscripts](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/subscripts/)
- [🍎Apple Docs: API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)

---

## 👬 팀 회고

## 우리팀이 잘한 점
- 프로젝트 종료시점에 기재하겠습니다.
## 우리팀 개선할 점
## 서로에게 좋았던 점 피드백
## 서로에게 아쉬웠던 점 피드백
