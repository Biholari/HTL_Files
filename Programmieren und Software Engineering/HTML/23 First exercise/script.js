let counter = 0;
const ul = document.querySelector("ul");

function addLi() {
	const li = document.createElement("li");
	li.textContent = counter;
	counter % 2 === 0 ? (li.style.color = "green") : (li.style.color = "red");
	ul.appendChild(li);
	counter++;
}

function reset() {
	ul.innerHTML = "";
}

const btn = document.querySelector(".add");
btn.addEventListener("click", addLi);
