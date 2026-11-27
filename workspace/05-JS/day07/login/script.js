// 로그인 검증 
const form = document.querySelector("#login-form");
const idInput = document.querySelector("#user-id");
const pwInput = document.querySelector("#user-pw");
const message = document.querySelector("#message");
const linkSignup = document.querySelector("#link-signup");
const linkFind = document.querySelector("#link-find");


// text: 메세지 내용
// type: 메세지 타입(에러, 성공, 일반)
function showMessage(text, type) {
    message.style.visibility = "visible";
    message.innerText = text;
    // 메세지 타입은 전달된 message 와 전달된 타입만을 설정하기 때문에
    // classList 보다 className 이 다루기가 쉽다.
    message.className = "message " + type;
}

function clearMessage() {
    message.style.visibility = "hidden";
    message.innerText = "";
    message.className = "message";
}


// form 요소의 submit 이벤트를 사용
//  → submit 버튼을 누를 때 발생하는 이벤트
//  → 입력 상태에 따라 서버에 전달하거나 
//    서버에 전달을 막고 메세지를 사용자에게 표시
form.addEventListener("submit", (e) => {
    e.preventDefault(); // 기본 이벤트 제거(= 제출 방지)
    
    // 입력 값
    const id = idInput.value.trim();
    const pw = pwInput.value;

    // 빈 값인지 검사
    if (!id) {
        // 에러 메세지 표시
        showMessage("계정을 입력해 주세요.", "error");
        // 사용자가 계정을 바로 입력할 수 있도록 포커스
        idInput.focus();
        // 더 이상 수행할 코드가 없기 때문에 종료
        return;
    }
    if(!pw) {
        showMessage("비밀번호를 입력해 주세요.", "error");
        pwInput.focus();
        return;
    }

});


// 계정 또는 비밀번호 입력 시 기존 메세지 지우기
idInput.addEventListener("input", clearMessage);
pwInput.addEventListener("input", clearMessage);


linkSignup.addEventListener("click", (e) => {
    // href='#' 인 요소를 클릭하면 현재 페이지의 상단으로 스크롤 이동
    e.preventDefault();
    showMessage("회원가입 페이지는 준비중입니다.");
});
linkFind.addEventListener("click", (e) => {
    e.preventDefault();
    showMessage("비밀번호 찾기 페이지는 준비중입니다.");
});