$(".btnChangePassword").click(function (e) {
    if ($(".txtNewPassword").val().replace(/\s+/g, ' ').trim() == "") {
        $.trim($(".txtNewPassword").val(''));
    }
    if ($(".txtTypeNewPassword").val().replace(/\s+/g, ' ').trim() == "") {
        $.trim($(".txtTypeNewPassword").val(''));
    }
})
//show and hide lable error when textbox null
$(".btnChangePassword").click(function (e) {
    if ($(".txtPassword").val() == "" || $(".txtNewPassword").val() == "" || $(".txtTypeNewPassword").val() == "") {

        e.preventDefault()
        if ($(".txtPassword").val() == "")
            $(".errPassword").css("display", "inline")
        if ($(".txtNewPassword").val() == "")
            $(".errNewPassword").css("display", "inline")
        if ($(".txtTypeNewPassword").val() == "")
            $(".errTypeNewPassword").css("display", "inline")
    }
})
//show and hide lable error when char over 8
$('.txtNewPassword').keydown(function () {
    if ($(".txtNewPassword").val().length > 7) {
        $(".errOverChar-NewPassword").css("display", "block")
    }
    else {
        $(".errOverChar-NewPassword").css("display", "none")
    }
})
$('.txtTypeNewPassword').keydown(function () {
    if ($(".txtTypeNewPassword").val().length > 7) {
        $(".errOverChar-TypeNewPassword").css("display", "block")
    }
    else {
        $(".errOverChar-TypeNewPassword").css("display", "none")
    }
})