// 회원가입 유효성 체크
function idCheck() {
    var id = $('#joinId').val();
    if (id.replace(/[a-z.0-9]/gi, '').length) {
        $('#idMessage').html('아이디는 영문, 숫자만 사용 가능합니다.');
        return false;
    } else if (id.length < 4) {
        $('#idMessage').html('아이디는 4-20자리만 사용 가능합니다.');
        return false;
    } else {
        $('#idMessage').html('&nbsp;');
        return true;
    }
};//idCheck()
function nameCheck() {
    var name = $('#joinName').val();
    if (name.replace(/[a-z.ㄱ-ㅎ.ㅏ-ㅣ.가-힣]/gi, '').length > 0) {
        $('#nameMessage').html('이름은 영문, 한글만 사용 가능합니다.');
        return false;
    } else if (name.length < 2) {
        $('#nameMessage').html('이름은 2-20자리만 사용 가능합니다.');
        return false;
    } else {
        $('#nameMessage').html('&nbsp;');
        return true;
    }
};//nameCheck()
function pwCheck1() {
    var password = $('#joinPw').val();
    if (password.replace(/[!-*.@]/gi, '').length >= password.length) {
        $('#pwMessage').html('비밀번호는 특수문자가 반드시 포함 되어야 합니다.')
        return false;
    } else if (password.length < 4) {
        $('#pwMessage').html('비밀번호는 4-20자리만 사용 가능합니다.')
        return false;
    } else if (password.replace(/[a-z.0-9.!-*.@]/gi, '').length > 0) {
        $('#pwMessage').html('비밀번호에 영문, 숫자가 반드시 포함 되어야합니다.')
        return false;
    } else {
        $('#pwMessage').html('&nbsp;');
        return true;
    }
};//pwCheck1()
function pwCheck2() {
    var passwordCheck = $('#joinPwCheck').val();
    if (passwordCheck.replace(/[!-*.@]/gi, '').length >= passwordCheck.length) {
        $('#pwCheckMessage').html('비밀번호가 일치하지 않습니다.')
        return false;
    } else if (passwordCheck.length < 4) {
        $('#pwCheckMessage').html('비밀번호가 일치하지 않습니다.')
        return false;
    } else if (passwordCheck.replace(/[a-z.0-9.!-*.@]/gi, '').length > 0) {
        $('#pwCheckMessage').html('비밀번호가 일치하지 않습니다.')
        return false;
    } else if ($('#joinPw').val() != passwordCheck) {
        $('#pwCheckMessage').html('비밀번호가 일치하지 않습니다.')
        return false;
    } else {
        $('#pwCheckMessage').html('&nbsp;');
        return true;
    }
};//pwCheck2()

// 로그인 유효성 체크
function loginIdCheck() {
    var id = $('#loginId').val();
    if (id.length === 0) {
        $('#loginIdMessage').html('아이디를 입력하세요.');
        return false;
    } else if (id.replace(/[a-z.0-9]/gi, '').length) {
        $('#idMessage').html('아이디는 영문, 숫자만 사용 가능합니다.');
        return false;
    } else if (id.length < 4) {
        $('#loginIdMessage').html('아이디는 4-20자리만 사용 가능합니다.');
        return false;
    } else {
        $('#loginIdMessage').html('&nbsp;');
        return true;
    }
} //loginIdCheck()
function loginPwCheck() {
    var password = $('#loginPw').val();
    if (password.length === 0) {
        $('#loginPwMessage').html('비밀번호를 입력하세요.')
        return false;
    } else if (password.replace(/[!-*.@]/gi, '').length >= password.length) {
        $('#loginPwMessage').html('비밀번호는 특수문자가 반드시 포함 되어야 합니다.')
        return false;
    } else if (password.length < 4) {
        $('#loginPwMessage').html('비밀번호는 4-20자리만 사용 가능합니다.')
        return false;
    } else if (password.replace(/[a-z.0-9.!-*.@]/gi, '').length > 0) {
        $('#loginPwMessage').html('비밀번호에 영문, 숫자가 반드시 포함 되어야합니다.')
        return false;
    } else {
        $('#loginPwMessage').html('&nbsp;');
        return true;
    }
} //loginPwCheck()


