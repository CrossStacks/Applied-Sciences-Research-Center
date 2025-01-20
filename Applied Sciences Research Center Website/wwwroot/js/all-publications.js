function updateCharCount() {
    const textBox = document.getElementById("researchDescription");
    const charCountDisplay = document.getElementById("char-count");

    const charCount = textBox.value.length;
    charCountDisplay.textContent = `Character count: ${charCount} / 1000`;
}

$(document).ready(function () {
    const searchContainer = $('.search-container');
    const searchBar = $('#search-bar');
    const searchIcon = $('#search-icon');

    var token = localStorage['token'];
    if (token && token != null) {
        $('#add-research-paper').removeAttr('hidden');
    }

    $(document).on('click', '.publication-container', function (e) {
        window.location.href = "publication?publicationSr=" + $(this).data('internalsr');
    });

    searchIcon.on('click', function () {
        if (!searchContainer.hasClass('expanded')) {
            searchContainer.addClass('expanded').css('width', '250px');
            searchBar.addClass('expanded').focus();
            searchIcon.addClass('expanded');
        } else if (searchBar.val().trim() === '') {
            searchBar.removeClass('expanded');
            searchContainer.removeClass('expanded').css('width', '50px');
            searchIcon.removeClass('expanded');
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
                searchIcon.removeClass('expanded');
            }
        }
    });

    $("#researchDescription").on("input", function () {
        updateCharCount();
    });

    $(document).ready(function () {
        $('#slideButton').click(function () {
            $('html, body').animate({
                scrollTop: $('#target').offset().top
            }, 50);
        });
    });

    $(document).on('click', '.delete-button', function (e) {
        if ($(this).data('internalsr') == '' || $(this).data('internalsr') == null) {
            console.log('SR was null');
            alert('Error while deleting. Please try again.');
            return;
        }

        $.post({
            url: baseUrl + '/Publication/Delete',
            type: 'DELETE',
            data: {
                sr: $(this).data('internalsr')
            },
            headers: { "Authorization": "Bearer " + localStorage['token'] }
        }).done(function (data) {
            // TODO: Add some kind of success message
            location.reload();
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error('Error deleting research paper:', textStatus);
            alert('Error while deleting. Please try again.');
        });
    });

    $(document).on('click', '.modify-button', function (e) {
        // TODO
        console.log('modify button clicked: ' + $(this).data('internalsr'));
    });

    $('#add-publication-button').on("click", function (event) {
        const researchTitle = $('#researchTitle').val().trim();
        const researchDescription = $('#researchDescription').val().trim();
        const researchUrl = $('#ResearchUrl').val().trim();

        if (!researchTitle || !researchDescription || !researchUrl) {
            console.log('Please fill in all the required fields.');
            // TODO Add alert
            return;
        }

        $.post({
            url: baseUrl + '/Publication/Create',
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

    $.get(baseUrl + "/Publication/GetAll", function (data, status) {
        if (status === "success") {
            var container = $(".row.g-4");
            container.empty();
            data.reverse();
            var token = localStorage['token'];

            data.forEach(function (item) {
                var color = '';

                if (item.type == 'Journal') {
                    color = 'text-danger'
                }
                else if (item.type == 'Book') {
                    color = 'text-succes'
                }
                else if (item.type == 'ResearchPaper') {
                    color = 'text-warning'
                }
                else if (item.type == 'Artical') {
                    color = 'text-info'
                }

                var cardHtml =
                    '<div class="col-md-4">' +
                    '<div class="card blog-card publication-container" data-internalSR="' + item.sr + '">' +
                    '<img src="' + (item.image || '') + '" class="card-img-top" alt="' + (item.altText || 'Journal image') + '">' +
                    '<div class="card-body">' +
                    '<span class="blog-tag ' + color + '">' + (item.type + ' presented at Event...' || '') + '</span>' +
                    '<h5 class="card-title mt-2">' + (item.title || 'Title not available') + '</h5>' +
                    '<p class="card-text">' + (item.description || 'Description not available') + '</p>' +
                    '<p class="blog-meta">' + (item.datePubish || 'Date not available') + '</p>' +
                    '<div class="dropdown position-absolute" style="top: 10px; right: 10px;" ' + (token ? '' : 'hidden') + '>' +
                    '<i class="bi bi-three-dots-vertical btn" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i>' +
                    '<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">' +
                    '<li><a class="dropdown-item bi bi-trash delete-button" data-internalSR="' + item.sr + '">Delete</a></li>' +
                    '<li><a class="dropdown-item bi bi-pen modify-button" data-internalSR="' + item.sr + '" href="#">Modify</a></li>' +
                    //'<li><a class="dropdown-item bi bi-eye hide-button" data-internalSR="' + item.sr + '" href="#">Show/Hide</a></li>' +
                    '</ul></div></div></div></div>';

                container.append(cardHtml);
            });
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log('Request failed while getting research papers: ' + textStatus);
    });
});
