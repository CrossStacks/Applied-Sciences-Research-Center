function updateCharCount() {
    const textBox = document.getElementById("researchDescription");
    const charCountDisplay = document.getElementById("char-count");

    const charCount = textBox.value.length;
    charCountDisplay.textContent = `Character count: ${charCount} / 1000`;
}

function updateNavbarBrand() {
    // Update only on smaller screens
    if ($(window).width() <= 991) {
        var activeLink = $("#navbar-second .nav-link.active");
        if (activeLink.length) {
            var activeText = activeLink.text();
            $("#navbar-second .navbar-brand").text(activeText);
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
    $('#navbar-nav').hide();

    $.get(baseUrl + "/ResearchPaper/Get?num=5",
        function (data, status) {
            if (status == "success") {
                data.reverse();

                for (var paper in data) {
                    var idOfSection = data[paper].title.replace(/ /g, '-');

                    $('#second-nav').append('<li class="nav-item"> <a class="nav-link" href="#' + idOfSection + '">' + data[paper].title + '</a> </li>');

                    $('#research-paper-section').append('<div id = "' + idOfSection + '" class= "container my-5">'
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
                $('#navbar-nav').show();
            }
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error('Request failed while getting research papers: ' + textStatus);
        });

    $("#researchDescription").on("input", function () {
        updateCharCount();
    });

    // TODO. if adding a new one with already used title then show alert
    $('#add-research-paper-button').on("click", function (event) {
        const researchTitle = $('#researchTitle').val().trim();
        const researchDescription = $('#researchDescription').val().trim();
        const researchUrl = $('#ResearchUrl').val().trim();

        if (!researchTitle || !researchDescription || !researchUrl) {
            console.log('Please fill in all the required fields.');
            // TODO Add alert
            return;
        }

        $.post({
            url: baseUrl + '/ResearchPaper/Create',
            data: {
                Title: researchTitle,
                UploaderEmail: localStorage['email'],
                Link: researchUrl,
                Description: researchDescription,
                ImageUrl: '', // TODO
            },
            headers: { "Authorization": "Bearer " + localStorage['token'] }
        }).done(function (data) {
            location.reload();
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error('Error submitting research paper:', textStatus);
            alert('Failed to submit the research paper. Please try again.');
        });
    });

    // Highlight the active nav-link on scroll and update navbar brand text
    $(window).on("scroll", function () {
        var scrollPosition = $(window).scrollTop();
        $("#navbar-second .nav-link").each(function () {
            var idOfSection = $(this).attr("href");
            idOfSection = idOfSection.replace(/ /g, '-');
            var section = $(idOfSection);
            if (section.length) {
                var sectionOffset = section.offset().top - 170;
                var sectionHeight = section.outerHeight();
                if (scrollPosition >= sectionOffset && scrollPosition < sectionOffset + sectionHeight) {
                    $("#navbar-second .nav-link").removeClass("active");
                    $(this).addClass("active");
                    updateNavbarBrand();
                }
            }
        });
    });
    updateNavbarBrand();

    // Update navbar brand text on window resize
    $(window).on("resize", function () {
        updateNavbarBrand();
    });
});
