$(document).ready(function () {
    $('#signInForm').on('submit', function (event) {
        event.preventDefault();
        const email = $('#email').val().trim();
        const password = $('#password').val().trim();

        if (email === '' || password === '') {
            alert('Please fill in all fields');
        } else {
            // Simulate sign-in action
            alert('Sign-In successful! Email: ' + email);
        }
    });
});
