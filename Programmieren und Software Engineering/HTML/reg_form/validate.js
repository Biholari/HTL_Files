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
    let error = false;

    let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    let passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;

    let invalidFields = [];
    let validFields = [];

    if (gender.value == "") {
        invalidFields.push("gender");
    } else {
        validFields.push("gender");
    }
    if (firstname.value == "") {
        invalidFields.push("firstname");
    } else {
        validFields.push("firstname");
    }
    if (lastname.value == "") {
        invalidFields.push("lastname");
    } else {
        validFields.push("lastname");
    }
    if (email.value == "") {
        invalidFields.push("email");
    } else {
        validFields.push("email");
    }
    if (password.value == "") {
        invalidFields.push("password");
    } else {
        validFields.push("password");
    }
    if (
        confirm_password.value != password.value ||
        confirm_password.value == ""
    ) {
        invalidFields.push("confirm_password");
    } else {
        validFields.push("confirm_password");
    }

    if (!emailRegex.test(email.value)) {
        error = true;
        invalidFields.push("email");
    } else {
        validFields.push("email");
    }
    if (!passwordRegex.test(password.value)) {
        error = true;
        invalidFields.push("password");
    } else {
        validFields.push("password");
    }

    if (!terms.checked) {
        error = true;
        invalidFields.push("terms");
    } else {
        validFields.push("terms");
    }

    for (let i = 0; i < validFields.length; i++) {
        document.getElementById(validFields[i]).classList.remove("invalid");
    }

    if (error) {
        for (let i = 0; i < invalidFields.length; i++) {
            document.getElementById(invalidFields[i]).classList.add("invalid");
        }
        return false;
    }

    alert("Das Formular wurder erfolgreich abgesendet. ");
    form.reset();
    return true;
}

document.getElementById("reset").addEventListener("click", function () {
    // Remove the "invalid" class from all input elements
    const inputs = document.querySelectorAll("input, select");
    inputs.forEach((input) => input.classList.remove("invalid"));
});

document.getElementById("register").addEventListener("click", function (event) {
    event.preventDefault();
    submit_form();
});
