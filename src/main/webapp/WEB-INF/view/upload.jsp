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
    <link rel="stylesheet" href="./css/upload.css"/>
    <title>UPLOAD</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/5.0.0/imagesloaded.pkgd.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
    <script defer src="./js/upload.js"></script>
    <!-- <script src="./resource/library/jquery_file_upload/jquery.fileupload.js"></script> -->
    <!-- TODO 만지지마~ -->
    <script src="./js/library/jquery.ui.widget.js" ></script>
    <script src="./js/library/jquery.iframe-transport.js" ></script>
    <script src="./js/library/jquery.fileupload.js"></script>
    <script>
        $(function() {

        }); //ready
    </script>
</head>
<body>
<!-- 헤더 -->
<header>
    <div class="inner">
        <a href="index" class="logo">
            <h2 class="logo-text">FreeStock</h2>
            <!-- <img src="../images/logo.png" alt="logo" class="logo"> -->
        </a>

        <div class="menu">
            <h2 class="hidden">사용자 메뉴</h2>
            <ul class="user-menu">
                <li id="jsLogin"><a href="javascript:void(0);" onclick="logout()">Logout</a></li>
                <li id="jsMypage"><a href="mypage">Mypage</a></li>
            </ul>
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
        <h2 class="hidden">업로드한 파일 보기</h2>
        <div class="file-wrapper">
        <%-- 파일 업로드하면 미리보기 나오는 곳 --%>
        </div>
        <h2 class="hidden">파일 업로드하기</h2>
        <form action="" method="POST" enctype="multipart/form-data" class="upload-form">
            <input type="text" id="fileTitle" class="file-title" placeholder="제목을 입력하세요.">

            <div class="fileUpload-btn-1">
                <label for="fileupload">
                    <div>클릭하여 파일 선택하기</div><br>
                    <p id="fileName"></p>
                    <p id="fileExt"></p>
                    <p id="fileSize"></p>
                </label>
            </div>
            <input id="fileupload" class="fileUpload-btn-2" type="file" name="files[]">

            <button type="button" id="upload" class="file-upload-btn">업로드</button>
            <button type="reset" id="uploadReset" class="file-reset-btn">취소</button>
        </form>
    </div>
    <div class="notion">
        <h2 class="hidden">업로드 안내</h2>
        <button id="fileInfo" class="file-info">파일 업로드 주의사항</button>
        <ul id="fileInfoP">
            <li>- 사진 및 일러스트 파일은 최소 300pixel 이상의 jpg, jpeg, png, bmp 포맷을 지원합니다.</li>
            <li>- 비디오 파일은 mp4, mpeg, mov, avi 포맷을 지원합니다.</li>
            <li>- 음악 파일은 mp3, wav 포맷을 지원합니다. </li>
            <li>- 사진 또는 일러스트 파일 업로드시 카테고리 선택에 유의하세요.</li>
            <li>- 허락 없이 타인의 창작물을 무단으로 복제 또는 배포하는 경우 게시물이 예고 없이 삭제될 수 있습니다.</li>
        </ul>

        <script>
            $(document).ready(function(){
                $('#fileInfo').click(function(){
                    $('#fileInfoP').toggle('600',function(){
                    });
                });
            });
        </script>
    </div>
</section>

<div id="to-top">
    <i class="fas fa-arrow-up"></i>
</div>

</body>
<%-- 카테고리 선택 다이얼로그--%>
<div id="dialog-message" title="Check category">
    업로드한 파일의 카테고리를 선택하세요.
</div>

<div id="dialog-upload">

</div>

<script>
    $(function () {
        // 1. 업로드 할 파일 선택하여 미리보기
        var uploadFiles;
        var category;

        $('#fileupload').fileupload({
            dataType: 'json',
            always: function(a, b) { // a: event / b: file
                var fr = new FileReader();
                fr.onload = function () {
                    var file = b.files[0].name; // 파일명
                    var ext = file.split('.').pop().toLowerCase(); // 파일 확장자

                    if (ext === 'jpg' || ext === 'jpeg' || ext === 'png' || ext === 'bmp') {
                        $('.file-wrapper').html('<img id="sampleImg" class="upload-img" src=""/>');
                        document.getElementById("sampleImg").src = fr.result;
                        document.getElementById("sampleImg").style.visibility = "visible";
                        $('#dialog-message').dialog({
                            modal: true,
                            //show: 'slide',
                            //hide: 'slide',
                            position: { my: "center", at: "center", of: window },
                            resizable: false,
                            buttons: {
                                "Photo": {
                                    text: "Photo",
                                    id: "categoryBtnP",
                                    click: function() {
                                        category = 'photo';
                                        console.log(category);
                                        $(this).dialog('close');
                                    }
                                },
                                "Illustration": {
                                    text: "Illustration",
                                    id: "categoryBtnI",
                                    click: function() {
                                        category = 'illustration';
                                        console.log(category);
                                        $(this).dialog('close');
                                    }
                                }
                            },
                            open: function() { // close click
                                $('.ui-button-icon').click(function() {
                                    $('.file-wrapper').html('');
                                    $('#fileName').text('');
                                    $('#fileExt').text('');
                                    $('#fileSize').text('');
                                    $('#fileTitle').val('');
                                    category = '';
                                });
                            }
                        });//dialog
                        uploadFiles = b.files;
                    }else if (ext === 'mp4' || ext === 'mpeg' || ext === 'mov' || ext === 'avi') {
                        $('.file-wrapper').html('<video id="sampleVideo" class="upload-video" src="" controls></video>');
                        document.getElementById("sampleVideo").src = fr.result;
                        document.getElementById("sampleVideo").style.visibility="visible";
                        uploadFiles = b.files;
                        category = 'video';
                    }
                    else if (ext === 'mp3' || ext === 'wav') {
                        $('.file-wrapper').html('<audio id="sampleMusic" class="upload-music" src="" controls></audio>');
                        document.getElementById("sampleMusic").src = fr.result;
                        document.getElementById("sampleMusic").style.visibility="visible";
                        uploadFiles = b.files;
                        category = 'music';
                    }else {
                        alert('업로드 할 수 없는 파일 형식입니다.');
                        $('#fileName').text('');
                        $('#fileExt').text('');
                        $('#fileSize').text('');
                    }
                }
                fr.readAsDataURL(b.files[0]);
                $('#fileName').text(b.files[0].name);
                $('#fileExt').text(b.files[0].name.split('.').pop().toLowerCase());
                $('#fileSize').text(b.files[0].size+' byte.');
                //console.log(b.files[0]); // ==> 파일 콘솔에 찍음->잘나옴
                //console.log("fr.readAsDataURL(b.files[0])=> "+fr.readAsDataURL(b.files[0]));
            }
            // done: function (e, data) {
            //     $.each(data.result.files, function (index, file) {
            //         console.log(file);
            //         $('<p></p>').text(file.name).appendTo(document.body);
            //     });
            // }
        });

        // 2. 서버에 파일 업로드 하기
        $('#upload').click(function() {
            // 파일 확장자 구해서 카테고리 지정하기
            //  var fileName = $("#fileName").text();
            //  var fileExt = $('#fileExt').text();

            console.log(uploadFiles);
            console.log(typeof uploadFiles);
            console.log('여기서 카테고리를 찾아요=> '+category); // => 이미지는 ''(카테고리 선택 전 먼저 출력됨), 비디오랑 음악은 잘 나옴
            if (uploadFiles == null || category == null) {
                alert('파일을 첨부하세요.');
            }else if ($('#fileTitle').val() == null || $('#fileTitle').val() == '') {
                alert('파일 제목을 입력하세요.');
            } else {
                var formdata = new FormData();
                formdata.append('file', uploadFiles[0]);
                formdata.append('title', $('#fileTitle').val());
                formdata.append('category', category);

                $.ajax({
                    type: 'POST',
                    url: '/api/board/insert',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("Authorization",sessionStorage.getItem("token"));
                    },
                    //processData: false,
                    contentType: false, //'multipart/form-data',
                    processData: false,
                    data: formdata,
                    //     JSON.stringify({
                    //     file: uploadFiles,
                    //     title: $('#fileTitle').val(),
                    //     category: category
                    // }),
                    success: function (result) {
                        alert('파일 업로드 성공');
                        // console.log(result);
                        // console.log(result.data.boardNo);
                        //var popup = window.open("about:blank", "_blank");

                        $.ajax({
                            type: 'GET',
                            url: '/api/board/'+result.data.boardNo,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader("Authorization",sessionStorage.getItem("token"));
                            },
                            success: function (result) {
                                //location.href('/'+category+'/board/'+result.data.boardNo);
                                // console.log(result);
                                // console.log(result.data.file);

                                // 바이트를 파일로 변환
                                var byte = atob(result.data.file);
                                var blob = byteCharToBlob(byte);
                                var url = window.URL.createObjectURL(blob);

                                if (category === 'photo' || category === 'illustration') {
                                    $('#dialog-upload').dialog({
                                        modal: true,
                                        width: "600px",
                                        position: { my: "center", at: "center", of: window },
                                        resizable: false,
                                        open: function() {
                                            $('#dialog-upload').html('<img src="'+url+'" style="width: 500px; align-items: center;"/>');
                                        },
                                        close: function() {
                                            url = '';
                                            $('.file-wrapper').html('');
                                            $('#fileName').text('');
                                            $('#fileExt').text('');
                                            $('#fileSize').text('');
                                            $('#fileTitle').val('');
                                            category = '';
                                        }
                                    });//dialog
                                    console.log('img');
                                }else if (category === 'video') {
                                    $('#dialog-upload').dialog({
                                        modal: true,
                                        width: "640px",
                                        position: { my: "center", at: "center", of: window },
                                        resizable: false,
                                        open: function() {
                                            $('#dialog-upload').html('<video src="'+url+'" style="width: 600px; margin: 0 auto;" controls></video>');
                                        },
                                        close: function() {
                                            url = '';
                                            $('.file-wrapper').html('');
                                            $('#fileName').text('');
                                            $('#fileExt').text('');
                                            $('#fileSize').text('');
                                            $('#fileTitle').val('');
                                            category = '';
                                        }
                                    });//dialog
                                }else if (category === 'music') {
                                    $('#dialog-upload').dialog({
                                        modal: true,
                                        width: "640px",
                                        position: { my: "center", at: "center", of: window },
                                        resizable: false,
                                        open: function() {
                                            $('#dialog-upload').html('<audio src="'+url+'" style="width: 600px; align-items: center; margin: 0 auto;" controls></audio>');
                                        },
                                        close: function() {
                                            url = '';
                                            $('.file-wrapper').html('');
                                            $('#fileName').text('');
                                            $('#fileExt').text('');
                                            $('#fileSize').text('');
                                            $('#fileTitle').val('');
                                            category = '';
                                        }
                                    });//dialog
                                }


                                console.log(url);


                            },
                            error: function (error) {
                                console.log(error);
                            }

                        });
                    },
                    error: function (error) {
                        alert('파일 업로드 에러');

                        console.log("error=> ", error);
                        console.log(this.data.get('file'));
                        console.log(uploadFiles);
                        console.log(this.data.get('title'));
                        console.log(this.data.get('category'));
                        console.log(this.data);

                    }
                }); //ajax
            }

        }); //upload()

    }); //ready

    // 바이트를 파일로 변환
    function byteCharToBlob (byteCharacters) {
        var len = byteCharacters.length;
        var bytes = new Uint8Array(len);
        for (var i = 0; i < len; i++) {
            bytes[i] = byteCharacters.charCodeAt(i);
        }
        return new Blob([bytes]);
    }

    // 리셋 버튼 클릭시 파일 미리보기 삭제
    $('#uploadReset').on('click', function() {
        $('.file-wrapper').html('');
        $('#fileName').empty();
        $('#fileExt').empty();
        $('#fileSize').empty();
        category = '';
        // document.getElementById("sample").src = '';
        // $("#fileName").empty();
        // $("#fileSize").empty();
    });

</script>
</html>
