<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- reset -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css"/>
    <!-- font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <!-- material icons -->
    <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
    <!-- css -->
    <link rel="stylesheet" href="./css/common.css"/>
    <link rel="stylesheet" href="./css/index.css"/>
    <title>INDEX</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/5.0.0/imagesloaded.pkgd.min.js"></script>
    <!-- jQuery Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
    <!-- gsap & scrollToPlugin -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.10.4/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.10.4/ScrollToPlugin.min.js"></script>
    <!-- scrollMaging -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"></script>
    <!-- selectbox -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
    <script defer src="./js/check.js"></script>
    <script defer src="./js/index.js"></script>
    <script defer src="./js/common.js"></script>
    <%-- jQuery File Download --%>
    <script src="./js/library/jquery.fileDownload.js"></script>
</head>
<body>
<!-- 로그인, 회원가입 모달-->
<div id="modal"></div>
<div class="modal-con loginModal">
    <a href="javascript:;" class="close-btn">
<%--        <span class="material-icons-round">close</span>--%>
        <i class="fas fa-times"></i>
    </a>
    <p class="title">Login</p>
    <div class="login-form">
        <form action="/index" method="get" id="loginForm">
            <span>아이디</span>
            <input id="loginId" type="text" placeholder="아이디를 입력하세요.">
            <span id="loginIdMessage" class="message">&nbsp;</span>
            <span>비밀번호</span>
            <input id="loginPw" type="password" placeholder="비밀번호를 입력하세요.">
            <span id="loginPwMessage" class="message">&nbsp;</span>
            <div class="btn-box">
                <button type="button" class="login-btn" id="axLogin">로그인</button>
                <button type="reset" class="reset-btn">취소</button>
            </div>
        </form>
    </div>
    <div class="find-pw">
        <a href="#">아이디/비밀번호를 잊어버리셨나요?</a>
    </div>
</div>

<!-- <div id="modal-join"></div> -->
<div class="modal-con joinModal">
    <a href="javascript:;" class="close-btn">
<%--        <span class="material-icons-round">close</span>--%>
        <i class="fas fa-times"></i>
    </a>
    <p class="title">Sign-up</p>
    <div class="join-form">
        <form action="" method="post" id="joinForm">
            <span>아이디</span>
            <input id="joinId" type="text" placeholder="아이디를 입력하세요.">
            <input id="idDupCheck" type="button" value="중복확인" onclick="idDupCheckF()">
            <span id="idMessage" class="message">&nbsp;</span>
            <span>이름</span>
            <input id="joinName" type="text" placeholder="이름을 입력하세요.">
            <span id="nameMessage" class="message">&nbsp;</span>
            <span>비밀번호</span>
            <input id="joinPw" type="password" placeholder="비밀번호를 입력하세요.">
            <span id="pwMessage" class="message">&nbsp;</span>
            <span>비밀번호 확인</span>
            <input id="joinPwCheck" type="password" placeholder="비밀번호를 다시 입력하세요.">
            <span id="pwCheckMessage" class="message">&nbsp;</span>
            <div class="btn-box">
                <button type="submit" class="join-btn" id="axJoin" onclick="return joinCheck()" disabled>가입</button>
                <button type="reset" class="reset-btn">취소</button>
            </div>
        </form>
    </div>
    <div class="help">
        <a href="#">도움이 필요하신가요?</a>
    </div>
</div>

<!-- 헤더 -->
<header>
    <div class="inner">
        <a href="index" class="logo">
            <h2 class="logo-text">FreeStock</h2>
            <!-- <img src="../images/logo.png" alt="logo" class="logo"> -->
        </a>

        <div class="menu">
            <h2 class="hidden">사용자 메뉴</h2>
            <ul class="user-menu"></ul>
            <button class="btn-upload" onclick="uploadLoginCheck();">UPLOAD</button>
<%--            location.href='upload';--%>
        </div>
    </div>
</header>

<!-- 네비게이션 -->
<nav>
    <div class="inner">
        <h2 class="hidden">메인 메뉴</h2>
        <ul class="main-menu">
            <li>
                <a href="photo">Photo</a>
            </li>
            <li>
                <a href="illustration">Illustration</a>
            </li>
            <li>
                <a href="video">Video</a>
            </li>
            <li>
                <a href="music">Music</a>
            </li>
        </ul>
    </div>
</nav>

<!-- 검색창 -->
<section>
    <!-- search box -->
    <div class="inner">
        <div class="inner-wrapper">
            <div class="inner-text">Download stunning files <br>for websites and commercial use!</div>
            <form action="/search" method="get" class="search-form">
                <div class="search-box">
                    <h2 class="hidden">카테고리 선택</h2>
                    <select name="wichiSearch" id="category">
                        <option value="사진" id="photo" selected>Photo</option>
                        <option value="일러스트" id="illustration">Illustration</option>
                        <option value="비디오" id="video">Video</option>
                        <option value="음악" id="music">Music</option>
                    </select>
                    <h2 class="hidden">검색창</h2>
                    <input type="text" maxlength="100" placeholder="검색어를 입력하세요." autocomplete="off">
                    <h2 class="hidden">검색 버튼</h2>
                    <button type="submit" class="search-btn">SEARCH</button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- 이미지 리스트 -->
<main>
    <div class="inner">
        <div class="grid-container"></div>
        <button class="main-btn" onclick="window.location.href='photo'">전체보기</button>
    </div>
</main>

<!-- 이미지 클릭시 상세보기  -->
<<!-- 이미지 클릭시 상세보기  -->
<div id="modal-img" onclick="closeImg()"></div>
<div class="modal-con imgModal">
    <a href="javascript:;" class="close-btn img-close" onclick="closeImg()">
        <%--        <span class="material-icons-round">close</span>--%>
        <i class="fas fa-times"></i>
    </a>
    <div class="img-box">
        <img src="" alt="" id="img-content">
    </div>
    <div class="img-info">
        <div class="img-title"></div>
        <div class="img-id"></div>
        <div class="img-createDate"></div>
        <div class=" hidden img-boardNo"></div>
        <input id="uuid" type="hidden" />
        <input id="fileName" type="hidden" />
        <input id="fileExtension" type="hidden" />

    </div>
    <div class="btn-wrap">
        <button class="like">
            <i class="fas fa-thumbs-up"></i>
            <span id="spanLikeCount" class="curr-like likeCount"></span>
        </button>
        <button id="file-download" class="img-btn" onclick="downloadImg()">다운로드</button>
    </div>
</div>

    <!-- 스크롤 탑 버튼 -->
<div id="to-top">
    <i class="fas fa-arrow-up"></i>
</div>


</body>
</html>
