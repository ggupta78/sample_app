// Menu manipulation

// Add toggle listeners to listen for clicks.

function addToggleListener(elementId, menuId, toggleClassName) {
  let element = document.querySelector(`#${elementId}`);
  if (element) {
    element.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector(`#${menuId}`);
      menu.classList.toggle(toggleClassName);
    });
  }
}

document.addEventListener("turbo:load", function() {
  addToggleListener("hamburger", "navbar-menu", "collapse");
  addToggleListener("account", "dropdown-menu", "active");
});
