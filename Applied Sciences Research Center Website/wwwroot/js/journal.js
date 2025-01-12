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

    $.get(baseUrl + "/ResearchPaper/GetAll", function (data, status) {
        if (status === "success") {
            var container = $(".row.g-4");
            container.empty();

            data.forEach(function (item) {
                var cardHtml = `
                    <div class="col-md-4">
                        <div class="card blog-card">
                            <img src="${item.image || ''}" class="card-img-top" alt="${item.altText || 'Journal image'}">
                            <div class="card-body">
                                <span class="blog-tag ${item.tagColor || ''}">${item.tag || 'Journal presented at Event...'}</span>
                                <h5 class="card-title mt-2">${item.title || 'Title not available'}</h5>
                                <p class="card-text">${item.description || 'Description not available'}</p>
                                <p class="blog-meta">${item.date || 'Date not available'} • ${item.readTime || 'N/A'}</p>
                                <div class="dropdown position-absolute" style="top: 10px; right: 10px;">
                                    <i class="bi bi-three-dots-vertical btn" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <li><a class="dropdown-item bi bi-trash" href="#">Delete</a></li>
                                        <li><a class="dropdown-item bi bi-pen" href="#">Modify</a></li>
                                        <li><a class="dropdown-item bi bi-eye" href="#">Show/Hide</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                container.append(cardHtml);
            });
        }
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log('Request failed while getting research papers: ' + textStatus);
    });
});
