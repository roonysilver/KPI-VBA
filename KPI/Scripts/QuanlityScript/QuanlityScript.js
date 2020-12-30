//change GUID when click button
$(".button_change_GUID").click(function () { ChangeGuid() })
function GuidGenerate() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}
function ChangeGuid() {
    $(".GUID").val(GuidGenerate())
}
$.ajax({
    type: "GET",
    url: "/api/DetailQuanlity",
    //data: '{}',
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function (response) {
        console.log(response)
    },
    failure: function (response) {
        console.log(response.data)
    },
    error: function (response) {
        console.log(response.data)
    }
});