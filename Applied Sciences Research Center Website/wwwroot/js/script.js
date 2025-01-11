let baseUrl = 'https://localhost:7079/api';

$(document).ready(function () {
    $('#add-research-paper').hide();
    $('#signup-button').hide();
    $('#option-button').hide();
    $('#add-research-paper').hide();

    var token = localStorage['token'];

    if (token) {
        $('#add-research-paper').show();
        $('#add-research-paper').show();
        $('#option-button').show();
    }
    else {
        $('#signup-button').show();
    }

    $("#signup-button").on("click", function () {
        window.location.href = "login";
    });

    $("#nav-home-button").on("click", function () {
        window.location.href = "home";
    });

    $("#nav-contact-button").on("click", function () {
        window.location.href = "contact-us";
    });
});