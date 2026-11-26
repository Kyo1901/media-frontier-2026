// example.js

// 뉴스 기사 목록
const rows = [
    { title: "여야 예산안 놓고 공방", section: "정치", reporter: "조채원", views: 3562 },
    { title: "반도체 정책 발표에 업계 촉각", section: "경제", reporter: "장지민", views: 5159 },
    { title: "미술관 전시 개막", section: "문화", reporter: "강도현", views: 12217 },
    { title: "수도권 조사 결과 공개", section: "사회", reporter: "조도현", views: 7720 },
    { title: "국내 기업 서비스 개편", section: "IT", reporter: "권민준", views: 9739 },
    { title: "국가대표 감독 교체", section: "스포츠", reporter: "오수빈", views: 10873 },
    { title: "K리그 결승 진출", section: "스포츠", reporter: "김예은", views: 847 },
    { title: "의료 관련 신고 급증", section: "사회", reporter: "김예은", views: 1109 },
    { title: "주거 제도 개선 요구", section: "사회", reporter: "조채원", views: 9859 },
    { title: "국가대표 결승 진출", section: "스포츠", reporter: "장태윤", views: null },
];

// 뉴스 카드 생성 함후
function makeCard({section, title, views, reporter}) { 
    const li = document.createElement("li");
    li.classList.add("card");

    const viewsStr= views === null ? "-" : views.toLocaleString();
    const reporterStr = reporter === null || reporter === undefined ? "-" : reporter;
    const inner = `
            <span class="badge">${section}</span>
            <a href="#">${title}</a>
            <dl>
                <dt>기자</dt>
                <dd>${reporterStr}</dd>
                <dt>조회</dt>
                <dd class="views">${viewsStr}</dd>
            </dl>
        `
    li.innerHTML = inner;
    return li;
}

// 뉴스 카드 표시 함수
function displayCard(rows) {
    list.innerText = "";
    list.append(...rows.map( makeCard ));
}



