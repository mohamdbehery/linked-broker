
var max = 200;
var remaining_chars;
$('#txtCommentMsg').on('input', function (e) {

    var len = $(e.currentTarget).val().length;
    remaining_chars = max - len;
    $('.comment-counter').text(remaining_chars >= 0 ? remaining_chars : 0);

    if (len > max)
        $(this).val($(this).val().slice(0, max - len));
});

$(document).ready(function () {
    $('#searchText').keypress(function (e) {
        if (e.which === 13) {
            $('form#search').submit();
            return false;
        }
    });
    var btnClicked = false;
    $('#btnAddComment').on("click", function () {
        if (btnClicked) return;
        btnClicked = true;
        var comment = {};
        comment.CommentMsg = $('#txtCommentMsg').val();
        if (comment.CommentMsg.trim() !== '') {
            $.ajax({
                url: '/api/AddComment/' + $('#CommentPostType').val() + '/' + $('#CommentPostID').val(),
                method: 'POST',
                data: comment,
                complete: function () { btnClicked = false; },
                success: function (d) {
                    btnClicked = false;
                    if (d) {
                        if (!d.UserImg) d.UserImg = '/img/person.png';
                        else d.UserImg = '/Uploads/PersonalImages/' + d.UserImg;

                        var temp = "<div class='comment-item'>" +
                            "<div class='comment-item-right'>" +
                            "<img src='" + d.UserImg + "'/>" +
                            "</div>" +
                            "<div class='comment-item-left'>" +
                            "<h4>" +
                            "<a href='/BrokerDetails/" + d.UserID + "'>" + d.UserName + "</a>" +
                            "<br />" +
                            "<label class='comment-date'><span class='en-number'>" + d.CreatedDate + "</span></label>" +
                            "<br />" +
                            "<label>" + d.CommentMsg + "</label>" +
                            "</h4>" +
                            "</div>" +
                            "</div >";
                        $('#txtCommentMsg').val('');
                        $('#comments-box').prepend(temp);
                        $('.no-comments').addClass('HideElement');
                        //window.location.reload();
                    }
                }
            });
        }
    });
});