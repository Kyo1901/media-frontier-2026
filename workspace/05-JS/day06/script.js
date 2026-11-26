
// 이벤트
//  - 사건 또는 상효작용이 발생한 상황
//  - 이벤트 처리
//      → 이벤트가 발생했을 때 수행할 기능을 구현
//  - 이벤트 객체
//      → 발생한 이벤트와 관련된 데이터들과
//        이벤트 처리를 도와줄 메서드들을 포함한 객체

// #reset 버튼 탐색
const btn = document.querySelector("#reset");

// 버튼을 클릭했을 때 콘솔에 로그를 출력
//  → 발생한 사건: 사용자의 클릭 = click
//  → 수행할 기능: 로그 출력

btn.addEventListener("click", (e) => { 
    // 이벤트 핸들러
    //  - 이벤트가 발생했을 때 수행되는 함수
    //  - 필요에 따라 이벤트 객체를 매개변수로 받는다.
    console.log("Button Clicked!");
    console.log(e);
});

const list = document.querySelector("#list");
list.addEventListener("click", (e) => { 
    e.target;           // → 실제 이벤트가 발생한 요소
    e.currentTarget;    // → 이벤트 핸들러(함수)를 수행하는 요소

    // a 요소(제목)를 클릭한 경우
    console.log(e.target.tagName);            // → a 요소
    console.log(e.currentTarget.tagName);     // → ul 요소
});

const searchBtn = document.querySelector("#searchForm button[type=submit]");
searchBtn.addEventListener("click", (e)=>{
    // console.log("Search Button Clicked!");
});

// 입력 양식인 요소들을 다룰 때 주의할 점
//  1. form 요소의 기본 이벤트는 "입력된 데이터들을 전달"하는 기능 = submit 이벤트
//      → 이벤트 발생 조건: 내부에 있는 submit 버튼을 누른 경우
//      → action 이 없으면 자기 자신을 다시 부른다.
//  2. 기본 이벤트를 가진 요소들의 기본 이벤트를 수행하지 않으려면
//     기본 이벤트를 제거해야한다.

const form = document.querySelector("#searchForm"); // 입력 폼
const q = document.querySelector("#q");             // 검색 필드

form.addEventListener("submit", (e)=>{
    // 기본 이벤트 제거 = 기본 이벤트를 수행하지 않는다.
    e.preventDefault();

    // 사용자가 검색한 내용(텍스트)
    //  → 무조건 문자열로 읽어온다.

    // 100 입력 후 전달
    console.log(q.value);           // 100
    console.log(q.value + 100);     // 100100
    console.log(Number(q.value) + 100);
    // → Number 함수를 이용하여 숫자로 만들 수 있다.
    
    // "" 입력 후 전달
    console.log(Number(q.value));       // 0
    console.log(Boolean(q.value));      // false
    
    // "   " 입력 후 전달
    console.log(Number(q.value));       // 0
    console.log(Boolean(q.value));      // true
    // → 빈 공백만 있어도 조건에서는 true 로 취급

    // 입력 값을 다룰 때는 사전에 처리할 과정이 필요
    //  1. 입력 요소에 HTML 속성을 설정
    //  2. trim() 을 통해 좌우 빈 공백을 제거
    //  3. 숫자 데이터로 다뤄야할 경우 Number() 함수를 사용
    console.log("|" + q.value.trim() + "|");
});