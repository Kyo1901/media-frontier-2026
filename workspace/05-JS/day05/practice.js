// ============================================================
//  실습 ⑤ — DOM
//
//  🔴 오늘 처음으로 «화면»을 건드립니다.
//     node 로는 못 돌립니다 — document 가 없습니다.
//     반드시 index.html 을 열고 F12 → Console 로 보세요.
//
//  🔴 화면이 실제로 바뀝니다. 새로고침하면 원래대로 돌아옵니다.
// ============================================================


// ── [1] 화면에서 하나 잡기 ─────────────────────────────────
//    · document.querySelector("#title") 로 제목을 잡으세요
//    · 없는 아이디("#없는아이디")도 한 번 잡아 보세요
//
//  제목의 글자(textContent)와, 없는 것을 잡은 결과를 한 줄에 찍으세요.
//
//  🔴 없는 것을 잡으면 오류가 납니까? 3일차 find 를 떠올려 보세요.
//  출력 형식:  [1] ? ?
const title =  document.querySelector("#title");

const nothing = document.querySelector("#noting"); 
// → 선택자를 잘못 지정한 경우 또는 요소가 만들어지지 않은 경우에는
//   null 을 반환하기 때문에 이후에 문제가 될 수 있다.
// → 탐색할 때는 오류가 발생하지 않기 때문에
//   오류가 발생하고 난 뒤 원인을 찾기에는 오래 걸릴 수 있다.

console.log("[1]", title.innerText, nothing);
// nothing.style.color = "red";

// ── [2] 여러 개 잡기 ───────────────────────────────────────
//    · document.querySelectorAll(".card") 로 카드를 전부 잡으세요
//    · 개수와, «첫 카드 안의» a 태그 글자를 한 줄에
//
//  🔴 카드 «안»에서 다시 찾을 수 있습니다 — cards[0].querySelector("a")
//  출력 형식:  [2] ? ?

const cards = document.querySelectorAll(".card");

// 첫 번째 카드의 a 태그의 글자
//  → 순번을 지정하고 a 요소를 지정
console.log("[2]", cards.length, cards[0].querySelector("a").innerText);


// ── [3] 🔴 오늘의 함정 — 이건 배열이 아닙니다 ──────────────
//  어제 배운 map 을 cards 에 그대로 쓰면 어떻게 될까요?
//
//    · Array.isArray(cards)                    ← 배열입니까?
//    · typeof cards.map === "function" 이면 "된다", 아니면 "없다"
//    · const 진짜배열 = [...cards];  →  Array.isArray(진짜배열)
//    · 진짜배열.map(...) 로 제목을 뽑은 «개수»
//
//  네 값을 한 줄에 찍으세요.
//
//  🔴 찍기 전에 넷을 종이에 적으세요. 어제 배운 것이 여기서 안 먹습니다.
//  출력 형식:  [3] ? ? ? ?

let includeMap = "";
if (typeof cards.map === "function"){
    includeMap = "포함";
} else {
    includeMap = "미포함";
}

const cardArray = [...cards];

const titleArray = cardArray.map((c) => c.querySelector("a").innerText)

console.log(
    "[3]", 
    Array.isArray(cards),       // false = cards 은 배열은 아니다. = NodeList
    includeMap,
    Array.isArray(cardArray),   // true = 전개를 통해 배열로 생성 
    titleArray.length
);



// ── [4] 글자 바꾸기 ────────────────────────────────────────
//    · 제목의 textContent 를 "정치" 로 바꾸세요
//    · #count 의 textContent 를 `기사 3건` 모양으로 바꾸세요
//      (1일차에 배운 템플릿 리터럴을 쓰세요)
//
//  🔴 바꾼 «뒤»에 화면을 보세요. 실제로 바뀌어 있습니다.
//  출력 형식:  [4] ? ?

title.innerText = "정치";

const count = document.querySelector("#count");
count.innerText = `기사 ${cards.length}건`;

console.log("[4]", title.innerText, count.innerText);

// ── [5] 클래스 바꾸기 ──────────────────────────────────────
//    · 첫 카드에 classList.add("hot") 을 하세요
//    · className 과, classList.contains("hot") 과,
//      document.querySelectorAll(".hot").length 를 한 줄에
//
//  🔴 className = "hot" 이라고 쓰면 어떻게 될까요?
//     한 번 해보고 «되돌린 뒤» 답을 적으세요.
//  출력 형식:  [5] ? ? ?

cards[0].classList.add("hot");
cards[0].classList.remove("hot");

console.log(
    "[5]",
    cards[0].className,
    cards[0].classList.contains("hot"),
    document.querySelectorAll(".hot").length
)



// ── [6] 만들어 붙이기 ──────────────────────────────────────
//  세 단계입니다 — 만들고 · 채우고 · 붙인다.
//
//    const li = document.createElement("li");
//    li.className = "card";
//    li.textContent = "새로 붙인 카드";
//    list.appendChild(li);
//
//  붙인 «뒤» #list 안의 li 개수와, 마지막 것의 글자를 한 줄에.
//  출력 형식:  [6] ? ?

const list = document.querySelector("#list");
const li = document.createElement("li");
li.classList.add("card");
li.innerText = "새로 붙인 카드";

list.appendChild(li);

console.log("[6]",
    document.querySelectorAll("#list > li.card").length,    // 4
    cards.length,   // 3 → 처음 저장된 3개가 그대로이다. = 실시간 반영 X
    list.lastElementChild.innerText // 새로 붙인 카드
);


// ── [7] 어제 rows 를 «화면에» 그립니다 ─────────────────────
//  아래 세 건을 카드로 만들어 #list 에 그리세요.
//
//    const rows = [
//      { title: "여야 예산안 놓고 공방", section: "정치", views: 3562 },
//      { title: "미술관 전시 개막", section: "문화", views: 12217 },
//      { title: "국가대표 결승 진출", section: "스포츠", views: null },
//    ];
//
//  🔴 뼈대는 아래대로입니다. 빈 곳 셋만 채우면 됩니다.
//
//    const list = document.querySelector("#list");
//    list.textContent = "";                       // 있던 것을 비운다
//
//    for (const r of rows) {
//      const card = document.createElement("li");
//      card.className = "card";
//
//      // ① span.badge 를 만들어 r.section 을 채우세요
//      // ② a 를 만들어 r.title 을 채우세요 (href 는 "#")
//      // ③ dd 를 만들고 className 을 "views" 로,
//      //    🔴 r.views 가 null 이면 "-" 로, 아니면 toLocaleString() 으로
//      //    (1일차 [3]·[4] 가 여기서 «화면»이 됩니다)
//
//      card.append(badge, a, views);
//      list.appendChild(card);
//    }
//
//  그려진 카드 개수와, 조회수들을 " / " 로 이어 한 줄에 찍으세요.
//  출력 형식:  [7] ? ?
//
//  🔴 다 되면 화면을 보세요. 지금까지 콘솔에만 있던 것이 눈에 보입니다.

const rows = [
    { title: "여야 예산안 놓고 공방", section: "정치", views: 3562 },
    { title: "미술관 전시 개막", section: "문화", views: 12217 },
    { title: "국가대표 결승 진출", section: "스포츠", views: null },
];

list.textContent = "";                       // 있던 것을 비운다

for (const r of rows) {
    const card = document.createElement("li");
    card.className = "card";

    // ① span.badge 를 만들어 r.section 을 채우세요
    const badge = document.createElement("span");
    badge.classList.add("badge");
    badge.innerText = r.section;

    // ② a 를 만들어 r.title 을 채우세요 (href 는 "#")
    const a = document.createElement("a");
    a.href = "#";
    a.innerText = r.title;

    // ③ dd 를 만들고 className 을 "views" 로,
    //    🔴 r.views 가 null 이면 "-" 로, 아니면 toLocaleString() 으로
    //    (1일차 [3]·[4] 가 여기서 «화면»이 됩니다)
    const views = document.createElement("dd");
    views.classList.add("views");
    views.innerText = r.views === null ? "-" : r.views.toLocaleString();

    card.append(badge, a, views);
    list.appendChild(card);
}

const newCardArray = [...document.querySelectorAll(".card")];

console.log("[7]",
    newCardArray.length,
    newCardArray.map((c) => c.querySelector(".views").innerText).join(" / ")
);


// ── [8] 🔴 textContent 와 innerHTML — 제목에 태그가 들어 있으면 ──
//  기자가 제목을 이렇게 써 보냈습니다.
//
//    const 제목 = "<b>속보</b> 예산안 통과";
//
//    · a 를 둘 만드세요 (createElement("a")) — a1 · a2
//    · a1 에는 textContent 로, a2 에는 innerHTML 로 제목을 넣으세요
//
//  a1 안의 b 요소 개수 · a2 안의 b 요소 개수 · a2 의 textContent 를 한 줄에.
//    (요소 «안»에서 찾기 — a1.querySelectorAll("b").length)
//
//  🔴 찍기 전에 종이에 적으세요. 둘 중 어느 쪽에 «태그»가 생겼습니까?
//     화면에 붙여 보고 싶으면 list.append(a1, a2) — 붙이지 않아도 답은 같습니다.
//  출력 형식:  [8] ? ? ?

// ← 여기


// ── ★[9] 함수 둘로 다시 씁니다 — 카드() 와 그리기() ─────────
//  [7] 의 for 안에서 하던 일을 «함수 둘»로 가릅니다.
//
//    function 카드({ section, title, views }) {
//      // [7] 의 for 안 그대로 — li 를 만들어 «돌려주세요» (return)
//      // 🔴 붙이지 마세요. 붙이는 것은 그리기() 가 합니다
//    }
//
//    function 그리기(rows) {
//      // ① list 를 비우고
//      // ② rows.map(카드) 로 li 배열을 만들어
//      // ③ list.append(...) 로 한꺼번에 붙이세요 (3일차 전개)
//    }
//
//  그다음 이렇게 부르고, 부를 «때마다» 화면의 카드 수를 세세요.
//
//    그리기(rows);                                  ← 첫째
//    그리기(rows);                                  ← 🔴 한 번 더
//    그리기(rows.filter((r) => r.views !== null));  ← 조회수 있는 것만
//
//  세 번의 카드 수와, 마지막 화면의 배지 글자들을 " / " 로 이어 한 줄에.
//    (카드 수는 document.querySelectorAll("#list .card").length)
//
//  🔴 첫째 숫자가 6 이면 ① 을 빼먹은 것입니다 — [7] 이 그린 3장 위에 쌓였습니다.
//  출력 형식:  [9] ? ? ? ?
//
//  🔴 마지막 줄이 9일차 종합 화면의 모양입니다 — 거르고 · 다시 그린다.


// 뉴스 카드를 만드는 함수
//  1. 뉴스 데이터를 받고
//  2. 화면에 표시할 카드를 생성
//  3. 카드에 데이터를 삽입
//  4. 카드 반환

// function makeCard(section, title, views, reporter) { }
// makeCard("정치", "여야 예산안 놓고 공방", 3562, "조재원");
// makeCard(rows[0].section, rows[0].title, rows[0].views, rows[0].reporter);

function makeCard({section, title, views, reporter}) { 
    const li = document.createElement("li");
    li.classList.add("li");

    // 생성 및 삽입 메서드가 다루기 어렵다면
    // 문자열 템플릿을 통해 HTML 마크업을 작성
    const viewsStr= views === null ? "-" : views.toLocaleString();
    const inner = `
            <span class="badge">${section})</span>
            <a href="#">${title}</a>
            <dl>
                <dt>기자</dt>
                <dd>${reporter}</dd>
                <dt>조회</dt>
                <dd class="views">${viewsStr}</dd>
            </dl>
        `
    return li;
}

console.log(makeCard(rows[0]));     // 완성 결과

