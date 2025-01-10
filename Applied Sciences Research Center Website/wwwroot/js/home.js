function updateCharCount() {
    const textBox = document.getElementById("researchDescription");
    const charCountDisplay = document.getElementById("char-count");

    const charCount = textBox.value.length;
    charCountDisplay.textContent = `Character count: ${charCount} / 1000`;
}

function updateNavbarBrand() {
    // Update only on smaller screens
    if ($(window).width() <= 991) {
        var activeLink = $(".navbar-second .nav-link.active");
        if (activeLink.length) {
            var activeText = activeLink.text();
            $(".navbar-second .navbar-brand").text(activeText);
        }
    }
}

function ensureHttps(link) {
    if (!link.startsWith('http://') && !link.startsWith('https://')) {
        return 'https://' + link;
    }
    return link;
}

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

    $.get(baseUrl + "/ResearchPaper/Get?num=5",
        function (data, status) {
            if (status == "success") {
                console.log(data);
                for (var paper in data) {
                    $('#second-nav').append('<li class="nav-item"> <a class="nav-link" href="#' + data[paper].title + '">' + data[paper].title + '</a> </li>');

                    $('#research-paper-section').append('<div id = "' + data[paper].title +'" class= "container my-5">'
                        + '<div class="research-page position-relative">'
                        + '<h2>' + data[paper].title + '</h2>'
                        + '<p>' + data[paper].description + '</p>'
                        + '<a href = "' + ensureHttps(data[paper].link) + '"> <p>' + data[paper].link + '</p> </a>'
                        + '<p>' + data[paper].uploaderEmail + '</p>'
                        + '<div class="dropdown position-absolute">'
                        + '<i class="bi bi-three-dots-vertical btn" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i>'
                        + '<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">'
                        + '<li><a class="dropdown-item bi bi-trash" href="#">Delete</a></li>'
                        + '<li><a class="dropdown-item bi bi-pen" href="#">Modify</a></li>'
                        + '<li><a class="dropdown-item bi bi-eye" href="#">Show/Hide</a></li>'
                        + '</ul> </div> </div> </div>');
                }
            }
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error('Request failed while getting research papers: ' + textStatus);
        });

    $("#researchDescription").on("input", function () {
        updateCharCount();
    });

    $("#signup-button").on("click", function () {
        window.location.href = "login";
    });

    // Highlight the active nav-link on scroll and update navbar brand text
    $(window).on("scroll", function () {
        var scrollPosition = $(window).scrollTop();
        $(".navbar-second .nav-link").each(function () {
            var section = $($(this).attr("href"));
            if (section.length) {
                var sectionOffset = section.offset().top - 70; // Adjust offset as needed
                var sectionHeight = section.outerHeight();
                if (
                    scrollPosition >= sectionOffset &&
                    scrollPosition < sectionOffset + sectionHeight
                ) {
                    $(".navbar-second .nav-link").removeClass("active");
                    $(this).addClass("active");
                    updateNavbarBrand();
                }
            }
        });
    });

    // Highlight the active link and update navbar brand text on page load
    //$(window).on("load", function () {
    updateNavbarBrand();
    //});

    // Update navbar brand text on window resize
    $(window).on("resize", function () {
        updateNavbarBrand();
    });
});
