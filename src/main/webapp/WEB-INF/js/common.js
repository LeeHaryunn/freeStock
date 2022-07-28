// 스크롤 버튼 숨기기, 상단가기
const toTop = document.querySelector('#to-top');
window.addEventListener('scroll', _.throttle(function() {
    if (window.scrollY > 280) {
        gsap.to(toTop, .4, {
            x: 0
        });
    }else {
        gsap.to(toTop, .4, {
            x: 100
        });
    }
}, 300));
toTop.addEventListener('click', function() {
    gsap.to(window, .7, {
        scrollTo: 0
    });
});

// 검색 셀렉트 스타일
$(document).ready(function() {
    $('#category').niceSelect();
});

// 모달 입력칸 초기화
function clearInput() {
    $("#loginId").val("");
    $("#loginPw").val("");
    $("#joinId").val("");
    $("#joinName").val("");
    $("#joinPw").val("");
    $("#joinPwCheck").val("");
    $("#idMessage").html("&nbsp;");
    $("#nameMessage").html("&nbsp;");
    $("#pwMessage").html("&nbsp;");
    $("#pwCheckMessage").html("&nbsp;");
    $("#loginIdMessage").html("&nbsp;");
    $("#loginPwMessage").html("&nbsp;");
}
// 모달 열기 닫기
function openModal(modalname){
    document.get
    $("#modal").fadeIn(300);
    $("."+modalname).fadeIn(300);
    clearInput();
}
$("#modal, .close-btn, .reset-btn").on('click',function(){
    $("#modal").fadeOut(300);
    $(".modal-con").fadeOut(300);
    clearInput();
});

// 회원가입, 로그인
var iCheck = false;
var nCheck = false;
var pCheck1 = false;
var pCheck2 = false;
var loginICheck = false;
var loginPCheck = false;

$(function() {
    // 로그인시 메뉴 변경
    if (sessionStorage.getItem("token") != null) {
        $(".user-menu").html('<li id="jsLogin"><a href="javascript:void(0);" onclick="logout()">Logout</a></li>' +
            '<li id="jsJoin"><a href="mypage">Mypage</a></li>');
    } else {
        $(".user-menu").html('<li id="jsLogin"><a href="javascript:openModal(\'loginModal\')" class="modal-open">Login</a></li>' +
            '<li id="jsJoin"><a href="javascript:openModal(\'joinModal\')">Sign-up</a></li>');
    }

    // 회원가입 유효성 검사
    $('#joinId').keydown(function(e){
        if(e.which == 9){
            e.preventDefault();
            $('#idDupCheck').focus();
        }
    }).focusout(function(){
        iCheck = idCheck();
    });//id
    $('#idDupCheck').keydown(function(e) {
        if(e.which == 9){
            e.preventDefault();
            $('#joinName').focus();
        }
    });
    $('#joinName').keydown(function(e){
        if(e.which == 9){
            e.preventDefault();
            $('#joinPw').focus();
        }
    }).focusout(function(){
        nCheck = nameCheck();
    });//name
    $('#joinPw').keydown(function(e){
        if(e.which == 9){
            e.preventDefault();
            $('#joinPwCheck').focus();
        }
    }).focusout(function(){
        pCheck1 = pwCheck1();
    });//pw
    $('#joinPwCheck').keydown(function(e){
        if(e.which == 13){
            e.preventDefault();
            $('#axJoin').focus();
        }
    }).focusout(function(){
        pCheck2 = pwCheck2();
    });//pwCheck
    // 회원가입
    /**
     * 컨트롤러의 파라미터가 @RequestBody 이면 json으로 보내야함
     * contentType: "application/json",
     * data: JSON.stringify(
     *      {a: "b", c: "d"}
     * )
     */
    $('#axJoin').click(function() {
        $.ajax({
            type: 'POST',
            url: '/api/auth/register',
            contentType: 'application/json',
            data: JSON.stringify({
                userId: $('#joinId').val(),
                userName: $('#joinName').val(),
                userPw: $('#joinPw').val(),
                userPwCheck: $('#joinPwCheck').val()
            }),
            success: function (result) {
                if (iCheck || nCheck || pCheck1 || pCheck2 == false) {
                    iCheck = idCheck();
                    nCheck = nameCheck();
                    pCheck1 = pwCheck1();
                    pCheck2 = pwCheck2();
                    alert('입력 정보를 확인해주세요.');
                } else {
                    alert('회원가입 성공'); // ==> 이거 안떠요
                    console.log(result);
                }
                // alert('회원가입이 완료되었습니다.');
                // console.log(result);
            },
            error: function (error) {
                alert('회원가입 에러');
                console.log(error);
            }
        });
    }); //axJoin

    // 로그인 유효성 검사
    $('#loginId').keydown(function(e){
        if(e.which == 9){
            e.preventDefault();
            $('#loginPw').focus();
        }
    }).focusout(function(){
        loginICheck = loginIdCheck();
    });//loginId
    $('#loginPw').keydown(function(e){
        if(e.which == 13){
            e.preventDefault();
            $('#axLogin').focus();
        }
    }).focusout(function(){
        loginPCheck = loginPwCheck();
    });//loginPw

    // 로그인
    $('#axLogin').click(function() {
        $.ajax({
            type: 'GET',
            url: '/api/auth/signin',
            contentType: "application/json",
            data: {
                userId: $('#loginId').val(),
                userPw: $('#loginPw').val(),
            },
            success: function(result) {
                if (result.statusCode === 200) {
                    alert("로그인 되었습니다.");
                    sessionStorage.setItem("token", result.data.accessToken);
                    console.log(result);
                    $("#modal").fadeOut(300);
                    $(".modal-con").fadeOut(300);
                    location.reload();
                } else {
                    alert("로그인 에러");
                    console.log(result);
                }
            },
            error: function(request, status, error) {
                //alert('로그인 에러');
                alert("request=> "+request.status+"/n"+"message=> "+request.responseText+"/n"+"error=> "+error);
            }
        });
    }); //axLogin

}); //ready

// 회원가입 버튼 체크
function joinCheck() {
    if (iCheck == false){$('#idMessage').html('필수 정보입니다.');}
    if (nCheck == false){$('#nameMessage').html('필수 정보입니다.');}
    if (pCheck1 == false){$('#pwMessage').html('필수 정보입니다.');}
    if (pCheck2 == false){$('#pwCheckMessage').html('필수 정보입니다.');}

    if (iCheck && nCheck && pCheck1 && pCheck2 == true) {
        if ( confirm('회원가입을 진행하시겠습니까?')  == false)  {
            alert('회원가입이 취소되었습니다.');
            clearInput();
            return false;
        }else{
            alert('회원가입이 완료되었습니다.');
            return true;
        }
    }else return false;
}//joinCheck()

// 아이디 중복 체크 (컨트롤러의 url이 GetMapping("") 이면 GET으로, url이 PostMapping 이면 POST로)
function idDupCheckF(){
    if (iCheck == false) {
        iCheck = idCheck();
    }else {
        $.ajax({
            type: 'GET',
            url: '/api/auth/search-id',
            data: {userId: $('#joinId').val()},
            success: function (result) {
                if (result.statusCode === 200) {
                    // 중복 없음
                    alert('사용 가능한 아이디 입니다.');
                    $('#axJoin').attr('disabled', false);
                } else {
                    // 중복
                    alert('사용 불가능한 아이디 입니다.')
                }
            },
            error: function (error) {
                alert('아이디 중복확인 에러');
                console.log('error' + error);
            }
        }); //ajax
    } //if else
}; //idDupCheckF()

// 로그아웃
function logout(){
    sessionStorage.removeItem("token");
    alert('로그아웃 되었습니다.');
    //location.reload();
    location.href = 'index';
} //logout()

// 비로그인시 업로드 메뉴 접근 불가
function uploadLoginCheck() {
    if (sessionStorage.getItem("token") == null) {
        alert('로그인이 필요한 서비스 입니다.');
        openModal('loginModal');
    } else {
        location.href='upload';
    }
} //uploadLoginCheck()

// 파일 다운로드
function downloadImg(filename) {
    if (sessionStorage.getItem("token") == null) {
        alert('로그인이 필요한 서비스 입니다.');
        $("#modal-img").fadeOut(300);
        $(".imgModal").fadeOut(300);
        openModal('loginModal');
    } else {
        // 파일 다운로드 시도
        const payload = {
            uuid: $("#uuid").val(),
            fileName: $("#fileName").val(),
            fileExtension: $("#fileExtension").val(),
        }

        $.fileDownload("/api/file/download", {
           httpMethod: "GET",
           data: payload,
            successCallback: function (url) {
               // 성공시
            },
            failCallback: function (responseHtml, url) {
               alert("다운로드 실패");
               // 실패시
            },
        });
    }
} //downloadImg()

// function download() {
//     if (sessionStorage.getItem("token") == null) {
//         alert('로그인이 필요한 서비스 입니다.');
//         //openModal('loginModal');
//     } else {
//         // 파일 저장
//     }
// } //downloadVideo()





