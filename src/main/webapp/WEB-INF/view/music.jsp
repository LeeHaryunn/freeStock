<%--
  Created by IntelliJ IDEA.
  User: cosmo
  Date: 2022/06/29
  Time: 3:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="./css/music.css"/>
    <title>music</title>
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

        <%-- 뮤직 플레이어 --%>
        <div id="app-cover">
            <div id="bg-artwork"></div>
            <div id="bg-layer"></div>
            <div id="player">
                <div id="player-track">
                    <div id="album-name"></div>
                    <div id="track-name"></div>
                    <div id="track-time">
                        <div id="current-time"></div>
                        <div id="track-length"></div>
                    </div>
                    <div id="s-area">
                        <div id="ins-time"></div>
                        <div id="s-hover"></div>
                        <div id="seek-bar"></div>
                    </div>
                </div>

                <div id="player-content">
                    <div id="player-controls">
                        <div class="control">
                            <div class="button" id="play-previous">
                                <i class="fas fa-backward"></i>
                            </div>
                        </div>
                        <div class="control">
                            <div class="button" id="play-pause-button">
                                <i class="fas fa-play"></i>
                            </div>
                        </div>
                        <div class="control">
                            <div class="button" id="play-next">
                                <i class="fas fa-forward"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn-wrap">
                    <button class="like">
                        <i class="fas fa-thumbs-up"></i>
                        <span class="curr-like likeCount">0</span>
                    </button>
                    <button class="down-btn" id="file-download" onclick="download()">다운로드</button>
                </div>
            </div>
        </div>

        <div class="playlist-wrap">
            <div class="music-playlist">
                <!-- 타이틀, 작성자, 시간 -->
                <div class="music-title">fun-life-112188</div>
                <div class="music-writer">admin</div>
                <div class="music-length">01:49</div>
                <button class="music-selected active">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
            <div class="music-playlist">
                <!-- 타이틀, 작성자, 시간 -->
                <div class="music-title">motivational-day-112790</div>
                <div class="music-writer">admin</div>
                <div class="music-length">02:32</div>
                <button class="music-selected">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
            <div class="music-playlist">
                <!-- 타이틀, 작성자, 시간 -->
                <div class="music-title">madirfan-both-of-us</div>
                <div class="music-writer">admin</div>
                <div class="music-length">02:48</div>
                <button class="music-selected">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
            <div class="music-playlist">
                <!-- 타이틀, 작성자, 시간 -->
                <div class="music-title">ambient-cinematic-hip-hop</div>
                <div class="music-writer">admin</div>
                <div class="music-length">03:02</div>
                <button class="music-selected">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
            <div class="music-playlist">
                <div class="music-title">trailer-sport-stylish-16073</div>
                <div class="music-writer">admin</div>
                <div class="music-length">03:01</div>
                <button class="music-selected">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
            <div class="music-playlist">
                <!-- 타이틀, 작성자, 시간 -->
                <div class="music-title">whip-110235</div>
                <div class="music-writer">admin</div>
                <div class="music-length">02:44</div>
                <button class="music-selected">
                    <i class="fas fa-check-square"></i>
                </button>
            </div>
        </div>

        <button class="more-btn">더보기</button>

    </div>
</main>

<!-- 스크롤 탑 버튼 -->
<div id="to-top">
    <i class="fas fa-arrow-up"></i>
</div>

<script>
    $(function(){
        var playerTrack = $("#player-track"),
            bgArtwork = $('#bg-artwork'),
            bgArtworkUrl,
            albumName = $('#album-name'),
            trackName = $('#track-name'),
            sArea = $('#s-area'),
            seekBar = $('#seek-bar'),
            trackTime = $('#track-time'),
            insTime = $('#ins-time'),
            sHover = $('#s-hover'),
            playPauseButton = $("#play-pause-button"),
            i = playPauseButton.find('i'),
            tProgress = $('#current-time'),
            tTime = $('#track-length'),
            seekT, seekLoc, seekBarPos, cM, ctMinutes, ctSeconds, curMinutes, curSeconds,
            durMinutes, durSeconds, playProgress, bTime,
            nTime = 0,
            buffInterval = null,
            tFlag = false,
            albums = ['fun-life-112188',
                'motivational-day-112790',
                'madirfan-both-of-us',
                'ambient-cinematic-hip-hop',
                'trailer-sport-stylish-16073',
                'whip-110235'],
            trackNames = ['admin',
                'admin',
                'admin',
                'admin',
                'admin',
                'admin'],
            albumArtworks = ['_1','_2','_3','_4','_5','_6'],
            trackUrl = ['./resources/music/fun-life-112188.mp3',
                        './resources/music/motivational-day-112790.mp3',
                        './resources/music/madirfan-both-of-us-14037.mp3',
                        './resources/music/ambient-cinematic-hip-hop-22168.mp3',
                        './resources/music/trailer-sport-stylish-16073.mp3',
                        './resources/music/whip-110235.mp3'],
            playPreviousTrackButton = $('#play-previous'),
            playNextTrackButton = $('#play-next'), currIndex = -1;

        // ui 동적 페이지
        // var result = albums.concat(trackNames, trackUrl);
        // var html;
        // console.log(result);
        //
        // $.each(result, function(index, item) {
        //     html += '<div class="music-title">'+item+'</div>'+
        //             '<div class="music-writer">작성자</div>'+
        //             '<div class="music-length">00:00</div>'+
        //             '<button class="music-selected"><i class="fas fa-check-square"></i></button>'
        // }) ;

        // 0701 추가
        // var musicTitle = $('#music-title');
        // var musicWriter = $('#music-writer');
        // var musicLength = $('#music-length');
        //
        // function setMusicInfo() {
        //     var audio = new Audio();
        //
        //     // 음악 시간 가져오는 코드 NaN 뜸
        //     durMinutes = Math.floor(audio.duration / 60);
        //     durSeconds = Math.floor(audio.duration - durMinutes * 60);
        //     if(durMinutes < 10)
        //         durMinutes = '0'+durMinutes;
        //     if(durSeconds < 10)
        //         durSeconds = '0'+durSeconds;
        //     if( isNaN(durMinutes) || isNaN(durSeconds) )
        //         musicLength.text('00:00');
        //     else
        //         musicLength.text(durMinutes+':'+durSeconds);
        //
        //     musicTitle.text(albums[0]);
        //     musicWriter.text(trackNames[0]);
        //     musicLength.text(durMinutes+':'+durSeconds);
        //
        //     console.log(trackNames[0]);
        //     console.log(durMinutes+':'+durSeconds);
        // }
        // setMusicInfo();

        // 셀렉트 버튼 선택시 색이 바뀌는 함수 --> 근데 하나만 적용됨 수정필요
        $('.music-selected').on('click', function() {
            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else{
                $(this).addClass("active");
            }
        });
        // 0701 끝

        function playPause(){
            setTimeout(function(){
                if(audio.paused){
                    playerTrack.addClass('active');

                    checkBuffering();
                    i.attr('class','fas fa-pause');
                    audio.play();
                }else{
                    playerTrack.removeClass('active');
                    clearInterval(buffInterval);
                    i.attr('class','fas fa-play');
                    audio.pause();
                }
            },300);
        }


        function showHover(event){
            seekBarPos = sArea.offset();
            seekT = event.clientX - seekBarPos.left;
            seekLoc = audio.duration * (seekT / sArea.outerWidth());

            sHover.width(seekT);

            cM = seekLoc / 60;

            ctMinutes = Math.floor(cM);
            ctSeconds = Math.floor(seekLoc - ctMinutes * 60);

            if( (ctMinutes < 0) || (ctSeconds < 0) )
                return;

            if( (ctMinutes < 0) || (ctSeconds < 0) )
                return;

            if(ctMinutes < 10)
                ctMinutes = '0'+ctMinutes;
            if(ctSeconds < 10)
                ctSeconds = '0'+ctSeconds;

            if( isNaN(ctMinutes) || isNaN(ctSeconds) )
                insTime.text('--:--');
            else
                insTime.text(ctMinutes+':'+ctSeconds);

            insTime.css({'left':seekT,'margin-left':'-21px'}).fadeIn(0);
        }

        function hideHover(){
            sHover.width(0);
            insTime.text('00:00').css({'left':'0px','margin-left':'0px'}).fadeOut(0);
        }

        function playFromClickedPos(){
            audio.currentTime = seekLoc;
            seekBar.width(seekT);
            hideHover();
        }

        function updateCurrTime(){
            nTime = new Date();
            nTime = nTime.getTime();

            if( !tFlag ){
                tFlag = true;
                trackTime.addClass('active');
            }

            curMinutes = Math.floor(audio.currentTime / 60);
            curSeconds = Math.floor(audio.currentTime - curMinutes * 60);

            durMinutes = Math.floor(audio.duration / 60);
            durSeconds = Math.floor(audio.duration - durMinutes * 60);

            playProgress = (audio.currentTime / audio.duration) * 100;

            if(curMinutes < 10)
                curMinutes = '0'+curMinutes;
            if(curSeconds < 10)
                curSeconds = '0'+curSeconds;

            if(durMinutes < 10)
                durMinutes = '0'+durMinutes;
            if(durSeconds < 10)
                durSeconds = '0'+durSeconds;

            if( isNaN(curMinutes) || isNaN(curSeconds) )
                tProgress.text('00:00');
            else
                tProgress.text(curMinutes+':'+curSeconds);

            if( isNaN(durMinutes) || isNaN(durSeconds) )
                tTime.text('00:00');
            else
                tTime.text(durMinutes+':'+durSeconds);

            if( isNaN(curMinutes) || isNaN(curSeconds) || isNaN(durMinutes) || isNaN(durSeconds) )
                trackTime.removeClass('active');
            else
                trackTime.addClass('active');


            seekBar.width(playProgress+'%');

            if( playProgress == 100 ){
                i.attr('class','fa fa-play');
                seekBar.width(0);
                tProgress.text('00:00');

                clearInterval(buffInterval);
            }
        }

        function checkBuffering(){
            clearInterval(buffInterval);
            buffInterval = setInterval(function(){
                bTime = new Date();
                bTime = bTime.getTime();
            },100);
        }

        function selectTrack(flag){
            if( flag == 0 || flag == 1 )
                ++currIndex;
            else
                --currIndex;

            if( (currIndex > -1) && (currIndex < albumArtworks.length) )
            {
                if( flag == 0 )
                    i.attr('class','fa fa-play');
                else
                {
                    i.attr('class','fa fa-pause');
                }

                seekBar.width(0);
                trackTime.removeClass('active');
                tProgress.text('00:00');
                tTime.text('00:00');

                currAlbum = albums[currIndex];
                currTrackName = trackNames[currIndex];
                currArtwork = albumArtworks[currIndex];

                audio.src = trackUrl[currIndex];

                nTime = 0;
                bTime = new Date();
                bTime = bTime.getTime();

                if(flag != 0)
                {
                    audio.play();
                    playerTrack.addClass('active');

                    clearInterval(buffInterval);
                    checkBuffering();
                }

                albumName.text(currAlbum);
                trackName.text(currTrackName);
                $('#'+currArtwork).addClass('active');

                bgArtworkUrl = $('#'+currArtwork).attr('src');

                bgArtwork.css({'background-image':'url('+bgArtworkUrl+')'});
            }
            else
            {
                if( flag == 0 || flag == 1 )
                    --currIndex;
                else
                    ++currIndex;
            }
        }

        function initPlayer()
        {
            audio = new Audio();

            selectTrack(0);

            audio.loop = false;

            playPauseButton.on('click',playPause);

            sArea.mousemove(function(event){ showHover(event); });

            sArea.mouseout(hideHover);

            sArea.on('click',playFromClickedPos);

            $(audio).on('timeupdate',updateCurrTime);

            playPreviousTrackButton.on('click',function(){ selectTrack(-1);} );
            playNextTrackButton.on('click',function(){ selectTrack(1);});
        }

        initPlayer();
    });
</script>
</body>
</html>
