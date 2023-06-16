// /**
//  * @param {string} password
//  * @returns {boolean} */
// function validatePassword(password) {
//     /** @type {RegExp} */
//     const hasDigit = /\d/;
//     /** @type {RegExp} */
//     const hasLowercase = /[a-z]/;
//     /** @type {RegExp} */
//     const hasUppercase = /[A-Z]/;
//     /** @type {RegExp} */
//     const hasSpecialCharacter = /[\W_]/;
//     /** @type {RegExp} */
//     const minLength = /.{8,}/;

//     return (
//         hasDigit.test(password) &&
//         hasUppercase.test(password) &&
//         hasLowercase.test(password) &&
//         hasSpecialCharacter.test(password) &&
//         minLength.test(password)
//     );
// }

// /** @type {Array.<string>} */
// const passwords = ["Abcdefg1@", "12345678", "Passowrd", "abc123", "Abc!@#123"];

// passwords.forEach((password) => {
//     console.log(`Password: ${password} \nValid: ${validatePassword(password)}`);
//     console.log("----");
// });

/** @type {HTMLInputElement} */
const checkTest = document.querySelector("#btnt");

checkTest.addEventListener("change", function () {
    /** @type {HTMLInputElement} */
    const btnt_text = document.querySelector("#btnt_text");
    if (checkTest.checked) {
        btnt_text.style.color = "red";
    } else {
        btnt_text.style.color = "";
    }
});
