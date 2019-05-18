//底部扩展键
$(function () {
    $('#doc-dropdown-js').dropdown({justify: '#doc-dropdown-justify-js'});
});
//个人信息
$('.am-dropdown .own_head').click(function () {
    $(this).next('div').css('display','block')
});
//除指定区域，点击关闭个人信息
$(document).click(function (e) {
    var $target = $(e.target);
    if(!$target.is('.am-dropdown-content')){
        $('.am-dropdown-content').css('display','none')
    }
})

$(function () {
    $(".office_text").panel({iWheelStep: 32});
});

//tab for three icon
$(document).ready(function () {
    $(".sidestrip_icon a").click(function () {
        $(".sidestrip_icon a").eq($(this).index()).addClass("cur").siblings().removeClass('cur');
        $(".middle").hide().eq($(this).index()).show();
    });
});

//input box focus
$(document).ready(function () {
    $("#input_box").focus(function () {
        $('.windows_input').css('background', '#fff');
        $('#input_box').css('background', '#fff');
    });
    $("#input_box").blur(function () {
        $('.windows_input').css('background', '');
        $('#input_box').css('background', '');
    });
});