$(function() {
    var axResult;
    var html = '';
    // 이미지 목록 불러오기
    $.ajax({
        type: 'GET',
        url: '/api/board/list',
        data: {
            lastNum: 0,
            category: 'photo'
        },
        beforeSend: function (xhr) {
            const token = sessionStorage.getItem("token");
            if (token != null) {
                xhr.setRequestHeader("Authorization", token);
            }
        },
        success: function(result) {
            // console.log(result);
            // console.log(result.data);
            // console.log(result.data[0].boardNo);
            //var html = '';
            $.each(result.data, function(index, item) {
                var byte = atob(item.file);
                var blob = byteCharToBlob(byte);
                var url = window.URL.createObjectURL(blob);

                html += '<div class="grid-item">' +
                    '<img class="grid-content" src="'+url+'"/>' +
                    '<span class="hidden title">'+item.title+'</span>' +
                    '<span class="hidden id">'+item.createId+'</span>' +
                    `<input type="hidden" name="_uuid" value="${item.uuid}" />` +
                    `<input type="hidden" name="_fileName" value="${item.fileName}" />` +
                    `<input type="hidden" name="_fileExtension" value="${item.fileExtension}" />` +
                    `<input type="hidden" name="_likeCount" value="${item.likeCount}" />` +
                    `<input type="hidden" name="_liked" value="${item.liked}" />` +
                    '<span class="hidden like">'+item.likeCount+'</span>' +
                    '<span class="hidden createDate">'+item.createDt+'</span>' +
                    '<span class="hidden boardNo boardNo'+item.boardNo+'">'+item.boardNo+'</span>' +
                    '</div>';
                // console.log('item=> '+item);
                // console.log('index=> '+index);
            }); //each
            $('.grid-container').html(html);
            axResult = result.data;
        },
        error: function (error) {
            console.log(error);
        }
    }); //ajax

    // 더보기 클릭
    $('.more-btn').on('click', function() {
        if (axResult == null || axResult === []) {
            return false;
        }
        $.ajax({
            type: 'GET',
            url: '/api/board/list',
            beforeSend: function (xhr) {
                const token = sessionStorage.getItem("token");
                if (token != null) {
                    xhr.setRequestHeader("Authorization", token);
                }
            },
            data: {
                lastNum: axResult[axResult.length - 1].boardNo,
                category: 'photo'
            },
            success: function(result) {
                console.log(result);
                console.log(axResult[axResult.length - 1].boardNo);

                axResult = result.data;
                if (result.data.length > 0) {
                    console.log(result.data.length);
                    $.each(result.data, function(index, item) {
                        var byte = atob(item.file);
                        var blob = byteCharToBlob(byte);
                        var url = window.URL.createObjectURL(blob);

                        html += '<div class="grid-item">' +
                            '<img class="grid-content" src="'+url+'"/>' +
                            '<span class="hidden title">'+item.title+'</span>' +
                            '<span class="hidden id">'+item.createId+'</span>' +
                            `<input type="hidden" name="_uuid" value="${item.uuid}" />` +
                            `<input type="hidden" name="_fileName" value="${item.fileName}" />` +
                            `<input type="hidden" name="_fileExtension" value="${item.fileExtension}" />` +
                            `<input type="hidden" name="_likeCount" value="${item.likeCount}" />` +
                            `<input type="hidden" name="_liked" value="${item.liked}" />` +
                            '<span class="hidden like">'+item.likeCount+'</span>' +
                            '<span class="hidden createDate">'+item.createDt+'</span>' +
                            '<span class="hidden boardNo boardNo'+item.boardNo+'">'+item.boardNo+'</span>' +
                            '</div>';
                    }); //each
                    $('.grid-container').html(html);
                } else {
                    alert('더이상 불러올 이미지가 없습니다.');
                    $(".more-btn").attr('disabled', true);
                }
            },
            error: function(error) {
                console.log(error);
            }
        }); //ajax
    }); //onclick

    // 동적 페이지 생성으로 인해 $(document).on 사용
    // 모달 오픈
    $(document).on("click", ".grid-content", function(){
        $('#img-content').attr('src', $(this)[0].src);
        $('.img-title').text($(this).next().text());
        $('.img-id').text($(this).siblings('.id').text());
        $('.img-createDate').text($(this).siblings('.createDate').text());
        $('.img-boardNo').text($(this).siblings('.boardNo').text());
        $('.likeCount').text($(this).siblings('.like').text());
        $("#uuid").val($(this).siblings("input[name=_uuid]").val());
        $("#fileName").val($(this).siblings("input[name=_fileName]").val());
        $("#fileExtension").val($(this).siblings("input[name=_fileExtension]").val());
        $("#spanLikeCount").text($(this).siblings("input[name=_likeCount]").val());
        if ($(this).siblings("input[name=_liked]").val() === "O") {
            $('.fa-thumbs-up').css('color', '#FA5F55');
        } else {
            $('.fa-thumbs-up').css('color', '#333');
        }
        $("#modal-img").fadeIn(300);
        $(".imgModal").fadeIn(300);
    });

    // 좋아요
    $('.like').click(function() {
        if (sessionStorage.getItem("token")) {
            $.ajax({
                type: 'POST',
                url: '/api/board/like/' + $('.img-boardNo').text(),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization",sessionStorage.getItem("token"));
                },
                success: function (result) {
                    console.log(result);
                    if (result.data) {
                        console.log('와앙;');
                        $('.fa-thumbs-up').css('color', '#FA5F55');
                        $("#spanLikeCount").text(parseInt($("#spanLikeCount").text()) + 1);

                        //$('body').load(location.href+' body');
                        //$('.img-boardNo').
                        //likeUpdate();
                        //$('.img-info').load(location.href+' .btn-wrap');
                        //$('.curr-like.likeCount').load(location.href+' .curr-like.likeCount');

                        //$('.boardNo'+$('.img-boardNo').text()).siblings('.like').css('color', 'red');
                        // $('.fa-thumbs-up').css('color', '#FA5F55');
                    } else {
                        $('.fa-thumbs-up').css('color', '#333');
                        $("#spanLikeCount").text(parseInt($("#spanLikeCount").text()) - 1);
                        //$('.like').load(location.href+' .like');
                    }
                },
                error: function (error) {
                    console.log(error);
                    console.log($('.img-boardNo').text());
                }
            });
        } else {
            alert("로그인이 필요한 서비스 입니다.");
            $("#modal-img").fadeOut(300);
            $(".imgModal").fadeOut(300);
            openModal('loginModal');
        }
    });

}); //ready

// 모달 클로즈
function closeImg() {
    //$("#modal-img, .img-close").on('click',function(){
    $("#modal-img").fadeOut(300);
    $(".imgModal").fadeOut(300);
}

// 바이트를 파일로 변환
function byteCharToBlob (byteCharacters) {
    var len = byteCharacters.length;
    var bytes = new Uint8Array(len);
    for (var i = 0; i < len; i++) {
        bytes[i] = byteCharacters.charCodeAt(i);
    }
    return new Blob([bytes]);
}
