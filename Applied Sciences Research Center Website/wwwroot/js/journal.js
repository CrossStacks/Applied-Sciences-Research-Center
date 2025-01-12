$(document).ready(function () {
    const searchContainer = $('.search-container');
    const searchBar = $('#search-bar');
    const searchIcon = $('#search-icon');

    searchIcon.on('click', function () {
        if (!searchContainer.hasClass('expanded')) {
            searchContainer.addClass('expanded').css('width', '250px');
            searchBar.addClass('expanded').focus();
        } else if (searchBar.val().trim() === '') {
            searchBar.removeClass('expanded');
            searchContainer.removeClass('expanded').css('width', '50px');
        }
    });

    searchBar.on('keypress', function (e) {
        if (e.key === 'Enter') {
            const query = searchBar.val().trim();
            if (query !== '') {
                console.log(`Searching for: ${query}`);
            }
        }
    });

    $(document).on('click', function (e) {
        if (!searchContainer.is(e.target) && searchContainer.has(e.target).length === 0) {
            if (searchBar.val().trim() === '') {
                searchBar.removeClass('expanded');
                searchContainer.removeClass('expanded').css('width', '50px');
            }
        }
    });
});
