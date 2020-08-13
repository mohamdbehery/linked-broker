var SiteConstants = window.SiteConstants || {};

$(document).ready(function () {
    var RelativeURL = window.location.pathname;
    DetectActiveHorizontalMenu(RelativeURL);
    DetectActiveVerticalMenu(RelativeURL);

    $('.imgModalClose').on('click', function () {
        $('#imgModal').css('display', 'none');
    });

    $('#divLandingSearch').on('click', function () {
        DOIt();
    });

    $('input[type=file]').change(function () { PreviewFiles(this) });
});

var PreviewFiles = function (fu) {
    $('.fu-img-preview').remove();
    $('.fu-img-error').remove();
    if (fu.files) {
        for (var i = 0; i < fu.files.length; i++) {
            if (fu.files[i].size > 5000000)
            {
                $(fu).parent().parent().append('<span class="fu-img-error"> عفوا يجب الا يزيد حجم الصورة عن 5 ميجا بايت </span>');
                break;
            }
            var reader = new window.FileReader();
            reader.onload = function (e) {
                $(fu).parent().parent().append('<img src="' + e.target.result + '" alt="preview" class="fu-img-preview" />');
            }
            reader.readAsDataURL(fu.files[i]);
        }
    }
}


var DOIt = function () {
    var IsVisible = $('#divLandingProperitiesSearch').is(":visible");
    if (IsVisible) {
        $('#divLandingProperitiesSearch').css('display', 'none');
        $('#divLandingSearch').removeClass('divLandingSearch-open');
    }
    else {
        $('#divLandingProperitiesSearch').css('display', 'block');
        $('#divLandingSearch').addClass('divLandingSearch-open');
    }
}

var DetectActiveHorizontalMenu = function (RelativeURL) {

    var RelativeURLs = RelativeURL.split('/');
    var curPage = RelativeURLs[RelativeURLs.length - 1];
    curPage = parseInt(curPage) > 0 ? RelativeURLs[RelativeURLs.length - 2] : curPage;
    $('.user-section-item').removeClass('user-section-item-active');
    $('.user-section-subitem').removeClass('user-section-subitem-active');
    $('.sub-tab').addClass('HideElement');

    var MenuLinks = $('#divMenuTabs a');
    for (var i = 0; i < MenuLinks.length; i++) {
        var ActiveLinkContainer = $(MenuLinks[i]).parent();

        var href = $(MenuLinks[i]).attr('href');
        var relPages = ActiveLinkContainer.attr('relPages');

        if (RelativeURL == href) {
            ActivateHorizontalMenu(ActiveLinkContainer);
        }

        if (relPages) {
            relPages = relPages.split(',');
            for (var j = 0; j < relPages.length; j++) {
                if (curPage == relPages[j]) {
                    ActivateHorizontalMenu(ActiveLinkContainer);
                }
            }
        }
    }
}

var DetectActiveVerticalMenu = function (RelativeURL) {

    var RelativeURLs = RelativeURL.split('/');
    var curPage = RelativeURLs[RelativeURLs.length - 1];
    curPage = parseInt(curPage) > 0 ? RelativeURLs[RelativeURLs.length - 2] : curPage;
    $('.ulVerticalMenuli').removeClass('navigation__active');

    var MenuLinks = $('#ulVerticalMenu a');
    for (var i = 0; i < MenuLinks.length; i++) {
        var ActiveLinkContainer = $(MenuLinks[i]).parent();

        var href = $(MenuLinks[i]).attr('href');
        var relPages = ActiveLinkContainer.attr('relPages');

        if (RelativeURL == href) {
            ActivateVerticalMenuMenu(ActiveLinkContainer, href);
        }

        if (relPages) {
            relPages = relPages.split(',');
            for (var j = 0; j < relPages.length; j++) {
                if (curPage == relPages[j]) {
                    ActivateVerticalMenuMenu(ActiveLinkContainer, href);
                }
            }
        }
    }
}

var ActivateHorizontalMenu = function (ActiveLinkContainer) {
    if (ActiveLinkContainer.hasClass('user-section-subitem')) {
        ActiveLinkContainer.parent().removeClass('HideElement');
        $('#' + ActiveLinkContainer.parent().attr('id').replace('SubTab', '')).addClass('user-section-item-active');
        ActiveLinkContainer.addClass('user-section-subitem-active');
    }
    else if (ActiveLinkContainer.hasClass('user-section-item'))
        ActiveLinkContainer.addClass('user-section-item-active');
}

var ActivateVerticalMenuMenu = function (ActiveLinkContainer, href) {
    ActiveLinkContainer.addClass('navigation__active');
    if(href.indexOf('Landing') != -1)
        $('#divForSale').addClass('user-section-item-active');
    else
        $('#divMyList').addClass('user-section-item-active');
}

var ShowModal = function (action, autohide, title, msg) {
    title = title ? title : 'تأكيد';
    msg = msg ? msg : 'هل أنت متأكد من الحذف ؟';
    action = action ? action : '#';
    $('#userModal .modal-title').text(title);
    $('#userModal .modal-body').text(msg);
    if (autohide) {
        $('#userModal .modal-footer').hide();
        $('#userModal .modal-body').css('text-align', 'center');
        $('#userModal').on('show.bs.modal', function () {
            var myModal = $(this);
            clearTimeout(myModal.data('hideInterval'));
            myModal.data('hideInterval', setTimeout(function () {
                myModal.modal('hide');
                window.open('/' + action, '_self');
            }, 5000));
        });
    }
    else {
        $('#userModal .modal-yes-btn').attr('action', action);
        $('#userModal .modal-yes-btn').on('click', function () { window.open('/' + $(this).attr('action'), '_self') });
    }

    $('#userModal').modal();
}

var MaximizaImage = function (ImageSrc) {
    //var ImageSrc = $(e.delegateTarget).attr('src');
    $('#imgModal').css('display', 'block');
    $('#imgModalSrc').attr('src', ImageSrc);
    $('.imgModalDownload').on('click', function () {
        DownloadFile(ImageSrc, '');
    });
}

var DownloadFile = function (URL, FileName) {
    var link = document.createElement('a');
    link.setAttribute('href', URL);
    link.setAttribute('download', FileName);
    link.style.display = 'none';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
};

var Refresh = function () {
    location.reload();
}

var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (x.length > 0) {
        if (n > x.length) { slideIndex = 1 }
        if (n < 1) { slideIndex = x.length };
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        x[slideIndex - 1].style.display = "block";
    }
}

var myIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (x.length > 0) {
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        myIndex++;
        if (myIndex > x.length) { myIndex = 1 }
        x[myIndex - 1].style.display = "block";
        //setTimeout(carousel, 2000); // Change image every 2 seconds
    }
}