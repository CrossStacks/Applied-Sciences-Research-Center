let baseUrl = 'https://localhost:7079/api';

$(document).ready(function () {
    $('#signup-button').hide();
    $('#logged-in-options').hide();

    $('#add-research-paper').hide();
    $('#add-research-paper').hide();

    var token = sessionStorage['token'];

    if (token && token != null) {
        $('#add-research-paper').show();
        $('#add-research-paper').show();
        $('#logged-in-options').show();
    }
    else {
        $('#signup-button').show();
    }

    $("#signup-button").on("click", function () {
        window.location.href = "login";
    });

    $("#logout-button").on("click", function () {
        token = null;
        sessionStorage.removeItem('token');
        location.reload();
    });

    $("#nav-home-button").on("click", function () {
        window.location.href = "home";
    });

    $("#nav-contact-button").on("click", function () {
        window.location.href = "contact-us";
    });
});