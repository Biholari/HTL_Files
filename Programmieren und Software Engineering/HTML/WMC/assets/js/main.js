/*=============== CHANGE BACKGROUND HEADER ===============*/
function scrollHeader(){
    const header = document.getElementById('header')
    // When the scroll is greater than 5 viewport height, add the scroll-header class to the header tag
    if(this.scrollY >= 5) header.classList.add('scroll-header'); else header.classList.remove('scroll-header')
}
window.addEventListener('scroll', scrollHeader)

/*=================== TIMING FOR COLOR ==================*/
const program = document.querySelector(".animated-gradient_foreground")
const preview = document.querySelector(".animated-gradient_foreground#purple")
const ship = document.querySelector(".animated-gradient_foreground#prime")
const card  = document.querySelector(".cover")
const button = document.querySelector(".show");

const elements = [program, preview, ship];

let current_color = "blue";

let i = 0;
let forward = true;

function iterateArray(element) {
    button.style.boxShadow = `0 0 30px ${current_color}`;

    button.addEventListener("mouseover", function() {
        button.style.background = "black";
    });
    button.addEventListener("mouseout", function() {
        button.style.background = "";
    });
    elements.forEach(el => {
        el.style.animation = "none";
    });
    element.style.animation = forward ? "animation-gradient 4s forwards" : "animation-gradient 4s reverse";
    setTimeout(() => {
        switch (i) {
            case 0:
                current_color = "purple";
                break;
            case 1:
                current_color = "peachpuff";
                break;
            case 2:
                current_color = "blue";
                break;
            default:
                break;
        }
        button.style.boxShadow = `0 0 30px ${current_color}`;
        i = (i + 1) % elements.length;
        forward = !forward;
        iterateArray(elements[i]);
    }, 4000)
}

iterateArray(program);

VanillaTilt.init(document.querySelector(".cover"), {
            speed: 400,
            transition: true,
            glare: true,
            max: 15,
});

card.addEventListener("click", function() {
    window.open("./../../product.html");
});

button.addEventListener("click", function() {
    window.open("./../../product.html");
})