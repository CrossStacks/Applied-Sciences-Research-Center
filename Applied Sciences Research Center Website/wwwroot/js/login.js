$(document).ready(function () {
    $('#signInForm').on('submit', function (event) {
        event.preventDefault();

        const email = $('#email').val().trim();
        const password = $('#password').val().trim();

        // const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

        if (!email) {
            alert('Email is required.');
        } else if (!emailRegex.test(email)) {
            alert('Please enter a valid email address.');
        } else if (!password) {
            alert('Password is required.');
        } else if (!passwordRegex.test(password)) {
            alert(
                'Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character.'
            );
        } else {
            alert('Sign-In successful! Email: ' + email);
        }

        $('#signInButton').click(function () {
            console.log('Sign-In successful! Email: ' + email);
        });
    });
});
