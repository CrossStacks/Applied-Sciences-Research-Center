$(document).ready(function () {
    $("#signup-button").click(function () {
        window.location.href = "login";
    });

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
    $(window).on("load", function () {
        updateNavbarBrand();
    });

    // Update navbar brand text on window resize
    $(window).on("resize", function () {
        updateNavbarBrand();
    });
});
