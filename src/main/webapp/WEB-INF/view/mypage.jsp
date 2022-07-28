<%--
  Created by IntelliJ IDEA.
  User: cosmo
  Date: 2022/07/12
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
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
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <!-- css -->
    <link rel="stylesheet" href="./css/common.css"/>
    <title>MyPage</title>
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
    <script defer src="./js/common.js"></script>
    <style>
        body {
            background-color: #333;
        }
        section {
            width: 100%;
            position: relative;
            top: 100px;
            background-color: #333;
        }
        section .inner {
            position: relative;
        }
        section .inner .edit-btn {
            background-color: #FA5F55;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            text-align: center;
            margin: 20px 0;
            position: absolute;
            right: 0;
            cursor: pointer;
        }
        section .inner .edit-btn>a {
            color: #fff;
        }
        section .inner .edit-btn i {
            font-size: 25px;
            line-height: 40px;
        }
        section .inner .edit-btn>a::after {
            content: "Edit";
            font-size: 14px;
        }
        /* 탭 메뉴 */
        section .inner .tap-wrapper{
            margin-top: 40px;
        }
        section .inner .tap-wrapper .tab {
            display: flex;
            /* width: 100%; */
            margin: 0 auto;
            padding: 20px;
            /* float: left; */
            justify-content: center;
        }
        section .inner .tap-wrapper .tab li {}
        section .inner .tap-wrapper .tab li a {
            color: #fff;
            text-align: center;
            text-decoration: none;
            padding: 10px;
        }
        section .inner .tap-wrapper .tab li a:first-child {
            margin-right: 50px;
        }
        .tabcont {
            display: none;
            color:black;
        }
        ul.tab li.on{
            text-decoration: underline;
        }
        .tabcont.on {
            display: block;
        }
        section .inner .menu-wrapper {}
        /* 업로드한 목록 */
        section .inner .menu-wrapper .tabcont .file-list {
            width: 900px;
            font-size: 14px;
            color: #333;
            background-color: #f0f0f0;
            border-radius: 15px;
            margin: 10px auto;
        }
        section .inner .menu-wrapper .tabcont .file-list td {
            font-size: 14px;
            width: 200px;
            color: #333;
            text-align: center;
            padding: 5px 0;
            padding: 10px 0;
        }
        section .inner .menu-wrapper .tabcont .file-list td>a {
            font-size: 14px;
            color: #333;
        }
        section .inner .menu-wrapper .tabcont .file-list td>a:hover {
            text-decoration: underline;
            font-weight: 600;
        }
        /* 좋아요한 목록 */
        section .inner .menu-wrapper .tabcont .like-list {
            width: 900px;
            font-size: 14px;
            color: #333;
            background-color: #f0f0f0;
            border-radius: 15px;
            margin: 10px auto;
        }
        section .inner .menu-wrapper .tabcont .like-list td {
            font-size: 14px;
            width: 200px;
            color: #333;
            text-align: center;
            padding: 5px 0;
            padding: 10px 0;
        }
        section .inner .menu-wrapper .tabcont .like-list td>a {
            font-size: 14px;
            color: #333;
        }
        section .inner .menu-wrapper .tabcont .like-list td>a:hover {
            text-decoration: underline;
            font-weight: 600;
        }

        /* 수정 모달 */
        #modal {
            display: none;
            position:fixed;
            width:100%; height:100%;
            top:0; left:0;
            background:rgba(0,0,0,0.3);
            z-index: 99;
        }
        .modal-con {
            display: none;
            position:fixed;
            top:50%; left:50%;
            transform: translate(-50%,-50%);
            width: 400px;
            height: 300px;
            background:white;
            border-radius: 25px;
            z-index: 99;
        }
        .modal-con .update-form {

        }
        .modal-con .update-form form .myinfo {
            margin: 20px auto 30px auto;
            border-top: 1px solid rgba(0, 0, 0, 0.2);
        }
        .modal-con .update-form form .myinfo caption {
            font-size: 20px;
            font-weight: 400;
            text-align: center;
            margin-bottom: 10px;
        }
        .modal-con .update-form .myinfo td {
            padding: 10px;
            text-align: center;
            /* border-bottom: 1px solid rgba(0, 0, 0, 0.2); */
        }
        .modal-con .update-form .myinfo input {
            all: unset;
            width: 150px;
            height: 30px;
            background-color: #f0f0f0;
            border-radius: 5px;
            padding-left: 5px;
            font-size: 13px;
        }
        .modal-con .update-form form .btn-wrap {
            width: 210px;
            margin: 0 auto;
            display: flex;
        }
        .modal-con .update-form form .update-btn {
            all: unset;
            cursor: pointer;
            width: 100px;
            height: 30px;
            margin-right: 10px;
            text-align: center;
            border-radius: 20px;
            background-color: #FA5F55;
            color: white;
            font-size: 13px;
            transition: .3s;
        }
        .modal-con .update-form form .update-btn:hover {
            background-color: #d7584f;
        }
        .modal-con .update-form form .update-reset {
            all: unset;
            cursor: pointer;
            margin-right: 10px;
            width: 100px;
            height: 30px;
            text-align: center;
            border-radius: 20px;
            color: #FA5F55;
            background-color: white;
            border: 1.5px solid #FA5F55;
            box-sizing: border-box;
            font-size: 13px;
            transition: .3s;
        }
        .modal-con .update-form form .update-reset:hover {
            background-color: #f0f0f0;
        }


    </style>
</head>
<script>
    $(function() {
        var html = '';

        $.ajax({
            type: 'GET',
            url: '/api/board/like/my',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization",sessionStorage.getItem("token"));
            },
            success: function(result) {
                console.log(result);
                $.each(result.data, function(index, item) {
                    html += '<tr>'+
                                    '<td>'+item.category+'</td>'+
                                    '<td><a href="#">'+item.title+'</a></td>'+
                                    '<td>'+item.createDt+'</td>'+
                                    '<td>'+
                                        '<i class="fas fa-thumbs-up"></i>'+
                                        '<span class="curr-like">'+item.likeCount+'</span>'+
                                    '</td>'+
                                '</tr>';

                });  //each
                $('.like-list').html(html);
            },
            error: function(error) {
                console.log(error);
            }

        }); //ajax

        // 탭 메뉴
        // $('ul.tab li').click(function() {
        //     var activeTab = $(this).attr('data-tab');
        //     $('ul.tab li').removeClass('on');
        //     $('.tabcont').removeClass('on');
        //     $(this).addClass('on');
        //     $('#' + activeTab).addClass('on');
        // });
    }); //ready

    // 정보수정 모달 닫기
    function closeEdit() {
        $("#modal").fadeOut(300);
        $(".editModal").fadeOut(300);
    }
</script>
<body>
<div id="modal" onclick="closeEdit()"></div>
<div class="modal-con editModal">
    <a href="javascript:;" class="close-btn" onclick="closeEdit()">
        <i class="fas fa-times"></i>
    </a>
    <div class="update-form">
        <form action="memberUpdate" method="post" enctype="multipart/form-data">
            <table class="myinfo">
                <caption>My Info</caption>
                <tr>
                    <td><label for="name">Name</label></td>
                    <td><input type="text" name=name id=name size="20" value="" readonly></td>
                </tr>
                <tr>
                    <td><label for="id">ID</label></td>
                    <td><input type="text" name="id" id="id" size="20" value="" readonly></td>
                </tr>
                <tr>
                    <td><label for="password">Password</label></td>
                    <td><input type="password" name="password" id="password" value="" readonly></td>
                </tr>
            </table>
            <div class="btn-wrap">
                <input class="update-btn" type="submit" value="수정">
                <input class="update-reset" type="button" value="탈퇴">
            </div>
        </form>
    </div>
</div>
<!-- 헤더 -->
<header>
    <div class="inner">
        <a href="index" class="logo">
            <h2 class="logo-text">FreeStock</h2>
        </a>

        <div class="menu">
            <h2 class="hidden">사용자 메뉴</h2>
            <ul class="user-menu"></ul>
            <button class="btn-upload" onclick="uploadLoginCheck();">UPLOAD</button>
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

<section>
    <div class="inner">
        <div class="edit-btn">
            <h2 class="hidden">개인정보 수정</h2>
            <a href="javascript:openModal('editModal')" class="modal-open"><i class="fas fa-user-circle"></i></a>
        </div>

        <div class="tap-wrapper">
            <ul class="tab">
                <h1 class="hidden">마이페이지 메뉴</h1>
<%--                <li class="on" data-tab="menu1"><a href="#">업로드 파일</a></li>--%>
                <li class="on" data-tab="menu2"><a href="#">좋아요 목록</a></li>
            </ul>
        </div>

        <div class="menu-wrapper">
<%--            <div id="menu1" class="tabcont on">--%>
<%--                <h1 class="hidden">업로드한 파일 목록</h1>--%>
<%--                <table class="file-list">--%>
<%--                    <tr>--%>
<%--                        <td id="fileType">파일 형식</td>--%>
<%--                        <td id="fileName"><a href="#">파일제목</a></td>--%>
<%--                        <td id="regDate">업로드 날짜</td>--%>
<%--                        <td id="like">--%>
<%--                            <i class="fas fa-thumbs-up"></i>--%>
<%--                            <span class="curr-like">00</span>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </table>--%>
<%--            </div>--%>

            <div id="menu2" class="tabcont on">
                <h1 class="hidden">좋아요한 파일 목록</h1>
                <table class="like-list">
<%--                    <tr>--%>
<%--                        <td>파일 형식</td>--%>
<%--                        <td><a href="#">파일제목</a></td>--%>
<%--                        <td>업로드 날짜</td>--%>
<%--                        <td>--%>
<%--                            <i class="fas fa-thumbs-up"></i>--%>
<%--                            <span class="curr-like">00</span>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- 스크롤 탑 버튼 -->
<div id="to-top">
    <i class="fas fa-arrow-up"></i>
</div>

</body>
</html>
