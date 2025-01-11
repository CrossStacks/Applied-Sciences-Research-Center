$(document).ready(function () {
    $('#error-alert').hide();

    $('#custom-button').on('click', function (event) {
        event.preventDefault();

        const email = $('#email').val().trim();
        const password = $('#password').val().trim();

        // const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

        // if (!password) {
        //     alert('Password is required.');
        // } else if (!passwordRegex.test(password)) {
        //     alert(
        //         'Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character.'
        //     );
        // } else {
        //     alert('Sign-In successful! Email: ' + email);
        // }

        $.get(baseUrl + "/Auth/Login",
            {
                Email: email,
                Password: password
            },
            function (data, status) {
                if (status == "success") {
                    sessionStorage['token'] = data.token;
                    window.location.href = "home";
                }
                else {
                    $('#error-alert').show();
                }
            }).fail(function (jqXHR, textStatus, errorThrown) {
                console.error('Request failed: ' + textStatus);
                $('#error-alert').show();
            });
    });
});
