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
    <link rel="stylesheet" href="./css/video.css"/>
    <%--  video style --%>
    <link href="https://vjs.zencdn.net/7.19.2/video-js.css" rel="stylesheet" />
    <link rel="stylesheet" href="./css/library/videojs-playlist-ui.css"/>
    <title>video</title>
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
    <%-- video --%>
    <%--<script src="https://vjs.zencdn.net/7.19.2/video.min.js"></script>--%>
    <script src="./js/library/video.js"></script>
    <script src="./js/library/videojs-playlist.js"></script>
    <script src="./js/library/videojs-playlist-ui.js"></script>
    <script defer src="./js/check.js"></script>
    <script defer src="./js/common.js"></script>
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

    <main>
        <div class="inner">
            <!-- 검색창 -->
            <form action="" method="">
                <div class="search-box">
                    <h2 class="hidden">카테고리 선택</h2>
                    <select name="wichiSearch" id="category">
                        <option value="제목" id="title" selected>제목</option>
                        <option value="작성자" id="author">작성자</option>
                    </select>
                    <h2 class="hidden">검색창</h2>
                    <input type="text" maxlength="100" placeholder="검색어를 입력하세요." autocomplete="off">
                    <h2 class="hidden">검색 버튼</h2>
                    <button type="submit" class="search-btn">SEARCH</button>
                </div>
            </form>

            <!-- video -->
            <div class="current-video">
                <video
                        id="player"
                        class="video-js vjs-big-play-button vjs-big-play-centered"
                        controls
                        preload="auto"
                        data-setup="{}">
                    <source src="./resources/video/Clouds - 64759.mp4" type="video/mp4" />
                </video>

                <div class="video-info">
                    <div class="video-title">video</div>
                    <div class="video-id">admin</div>
                    <div class="video-createDate">2022-07-25</div>
                    <button id="file-download" class="video-btn" onclick="download()">다운로드</button>
                    <button class="like-btn">
                        <i class="fas fa-thumbs-up"></i>
                        <span class="curr-like likeCount">0</span>
                    </button>
                </div>
            </div>

            <!-- 재생 가능한 비디오 목록 -->
            <div class="playlist-title">View more viedos.</div>
            <div class="vjs-playlist-wrapper">
                <div class="vjs-playlist">
                    <!--  -->
                </div>
            </div>


            <script>
                $(function(){
                    // TODO 비디오~~~
                    // $.ajax({
                    //     type: 'GET',
                    //     url: '/api/board/list',
                    //     beforeSend: function (xhr) {
                    //         const token = sessionStorage.getItem("token");
                    //         if (token != null) {
                    //             xhr.setRequestHeader("Authorization", token);
                    //         }
                    //     },
                    //     data: {
                    //         lastNum: 0,
                    //         category: 'video'
                    //     },
                    //     success: function(result) {
                    //         console.log(result);

                            // var byte = atob(result.data[0].file);
                            // var blob = byteCharToBlob(byte);
                            // var url = window.URL.createObjectURL(blob);

                            // TODO photo랑 비슷하게 하려고 했는데 안됨 ㅎㅅㅎ,,,,
                            <%--var video = `<video`+--%>
                            <%--    `id="player"`+--%>
                            <%--    `class="video-js vjs-big-play-button vjs-big-play-centered"`+--%>
                            <%--    `controls`+--%>
                            <%--    `preload="auto"`+--%>
                            <%--    `data-setup="{}">`+--%>
                            <%--    `<source src="${url}" type="video/mp4" />`+--%>
                            <%--    `</video>`+--%>
                            <%--    `<div class="video-info">`+--%>
                            <%--    `<div class="video-title">${result.data[0].title}</div>`+--%>
                            <%--    `<div class="video-id">${result.data[0].createId}</div>`+--%>
                            <%--    `<div class="video-createDate">${result.data[0].createDt}</div>`+--%>
                            <%--    `<button id="file-download" class="video-btn" onclick="download()">다운로드</button>`+--%>
                            <%--    `<button class="like-btn">`+--%>
                            <%--        `<i class="fas fa-thumbs-up"></i>`+--%>
                            <%--        `<span class="curr-like likeCount"></span>`+--%>
                            <%--    `</button>`+--%>
                            <%--    `</div>`;--%>
                            <%--$('.current-video').html(video);--%>

                            // $('.video-title').text(result.title);
                            // $('.video-id').text(result.id);
                            // $('.video-createDate').text(result.createDt);
                    //     },
                    //     error: function(error) {
                    //         console.log(error);
                    //     }
                    // }); //ajax

                    // 재생목록 불러오기
                    var player = videojs('player');
                    player.playlistUi();
                    player.playlist([{
                        name: 'Clouds',
                        sources: [{
                            src: './resources/video/Clouds - 64759.mp4',
                            type: 'video/mp4'
                        }],
                        thumbnail: [{
                            srcset: 'https://i.vimeocdn.com/video/1057469157-c245b57b45f3b6aa545a9f5cad4fd99ed3f38c936ed049f3f5653aad0b75541a-d_640x360.jpg',
                            type: 'image/jpg',
                        },
                            {
                                src: 'https://i.vimeocdn.com/video/1057469157-c245b57b45f3b6aa545a9f5cad4fd99ed3f38c936ed049f3f5653aad0b75541a-d_640x360.jpg'
                            }]
                    },
                        {
                            name: 'Record',
                            sources: [{
                                src: './resources/video/Record - 65390.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/1064479005-ba2a2f2f3a3d7946b2ab3145b5bda48e65b8a1ae73d675129e6e88bba5fd2dbb-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/1064479005-ba2a2f2f3a3d7946b2ab3145b5bda48e65b8a1ae73d675129e6e88bba5fd2dbb-d_640x360.jpg'
                                }]
                        },
                        {
                            name: 'Jellyfish',
                            sources: [{
                                src: './resources/video/Jellyfish - 110877.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/1396219770-fd071a179609064d376964005f900e1bbabda2b808635d4e89ae15556f6f1949-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/1396219770-fd071a179609064d376964005f900e1bbabda2b808635d4e89ae15556f6f1949-d_640x360.jpg'
                                }]
                        },
                        {
                            name: 'Sakura',
                            sources: [{
                                src: './resources/video/Sakura - 110790.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/1394747938-6300911296bba5ae905729bc972471d4f63afd7e3adb37bd6ef21268ec7db88a-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/1394747938-6300911296bba5ae905729bc972471d4f63afd7e3adb37bd6ef21268ec7db88a-d_640x360.jpg'
                                }]
                        },
                        {
                            name: 'Ocean',
                            sources: [{
                                src: './resources/video/Ocean - 74888.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/1144440814-92e55ff42a045fadba0d6477c0541b80807b1e0c68e7cc8d3daf78df805a57c5-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/1144440814-92e55ff42a045fadba0d6477c0541b80807b1e0c68e7cc8d3daf78df805a57c5-d_640x360.jpg'
                                }]
                        },
                        {
                            name: '모래놀이',
                            sources: [{
                                src: './resources/video/sand__ - 73847.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/1137777671-7649d52d5684fd9c9e9f47cb7905f8304dde316cb8a32d6ab7983a67fc94dfc6-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/1137777671-7649d52d5684fd9c9e9f47cb7905f8304dde316cb8a32d6ab7983a67fc94dfc6-d_640x360.jpg'
                                }]
                        },
                        {
                            name: '바다',
                            sources: [{
                                src: './resources/video/video- 4006.mp4',
                                type: 'video/mp4'
                            }],
                            thumbnail: [{
                                srcset: 'https://i.vimeocdn.com/video/583481279-cb986541e5371d720aa372625619372d35070e727d7972c7a5e111abb3fc123c-d_640x360.jpg',
                                type: 'image/jpg',
                            },
                                {
                                    src: 'https://i.vimeocdn.com/video/583481279-cb986541e5371d720aa372625619372d35070e727d7972c7a5e111abb3fc123c-d_640x360.jpg'
                                }]
                        }
                    ]);
                    $('.video-title').text()

                    // 다음 영상 자동재생
                    player.playlist.autoadvance(0);

                });//ready


                // 바이트를 파일로 변환
                function byteCharToBlob (byteCharacters) {
                    var len = byteCharacters.length;
                    var bytes = new Uint8Array(len);
                    for (var i = 0; i < len; i++) {
                        bytes[i] = byteCharacters.charCodeAt(i);
                    }
                    return new Blob([bytes]);
                }
            </script>

        </div> <!-- inner -->
    </main>

    <!-- 스크롤 탑 버튼 -->
    <div id="to-top">
        <i class="fas fa-arrow-up"></i>
    </div>
</body>
</html>
