let baseUrl = 'https://localhost:7079/api';

$(document).ready(function () {
    var token = localStorage['token'];

    if (token && token != null) {
        $('#add-research-paper').removeAttr('hidden');
        $('#logged-in-options').removeAttr('hidden');
    }
    else {
        $('#signup-button').removeAttr('hidden');
    }

    $("#signup-button").on("click", function () {
        window.location.href = "login";
    });

    $("#logout-button").on("click", function () {
        token = null;
        localStorage.removeItem('token');
        location.reload();
    });

    $("#nav-home-button").on("click", function () {
        window.location.href = "home";
    });

    $("#nav-contact-button").on("click", function () {
        window.location.href = "contact-us";
    });

    $("#nav-publications-button").on("click", function () {
        window.location.href = "publications";
    });
});