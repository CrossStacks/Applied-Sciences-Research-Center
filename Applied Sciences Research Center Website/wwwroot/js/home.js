$(document).ready(function () {
  $("#signup-button").click(function () {
    window.location.href = "signup.html";
  });

  $(window).on("scroll", function () {
    var scrollPosition = $(window).scrollTop();
    $(".navbar-second .nav-link").each(function () {
      var section = $($(this).attr("href"));
      if (section.length) {
        var sectionOffset = section.offset().top - 60;
        var sectionHeight = section.outerHeight();
        if (
          scrollPosition >= sectionOffset &&
          scrollPosition < sectionOffset + sectionHeight
        ) {
          $(".navbar-second .nav-link").removeClass("active");
          $(this).addClass("active");
        }
      }
    });
  });

  // Highlight the active link on page load
  $(window).on("load", function () {
    $(".navbar-second .nav-link").each(function () {
      if (window.location.hash === $(this).attr("href")) {
        $(".navbar-second .nav-link").removeClass("active");
        $(this).addClass("active");
      }
    });
  });
});
