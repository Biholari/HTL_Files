// Get form elements
const form = document.querySelector("#myForm");
const gender = document.querySelector("#gender");
const firstname = document.querySelector("#firstname");
const lastname = document.querySelector("#lastname");
const email = document.querySelector("#email");
const password = document.querySelector("#password");
const confirm_password = document.querySelector("#confirm_password");
const terms = document.querySelector("#terms");

function submit_form() {
    let errorMessage = "";

    let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    let passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;

    let invalidFields = [];

    if (gender.value == "") {
        invalidFields.push("gender");
    }
    if (firstname.value == "") {
        invalidFields.push("firstname");
    }
    if (lastname.value == "") {
        invalidFields.push("lastname");
    }
    if (email.value == "") {
        invalidFields.push("email");
    }
    if (password.value == "") {
        invalidFields.push("password");
    }
    if (confirm_password.value != password.value) {
        invalidFields.push("confirm_password");
    }

    if (!emailRegex.test(email.value)) {
        errorMessage += "Bitte geben Sie eine gültige E-Mail Adresse ein \n";
        invalidFields.push("email");
    }

    if (!passwordRegex.test(password.value)) {
        errorMessage +=
            "Das Passwort muss mindestens 8 Zeichen lang sein und mindestens eine Zahl, einen Groß- und einen Kleinbuchstaben sowie ein Sonderzeichen enthalten \n";
        invalidFields.push("password");
    }

    if (!terms.checked) {
        errorMessage += "Bitte akzeptieren Sie die AGB \n";
        invalidFields.push("terms");
    }

    if (errorMessage != "") {
        for (let i = 0; i < invalidFields.length; i++) {
            document.getElementById(invalidFields[i]).style.backgroundColor =
                "red !important";
        }
        alert(errorMessage);
        return false;
    }

    alert("Das Formular wurder erfolgreich abgesendet. ");
    document.getElementById("myForm").requestFullscreen();
    return true;
}

document.querySelector("#myForm").addEventListener("submit", function (event) {
    event.preventDefault();
    submit_form();
});
