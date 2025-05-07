import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("DOMContentLoaded", () => {
  const flashNotice = document.getElementById("flash-notice");
  const flashAlert = document.getElementById("flash-alert");

  [flashNotice, flashAlert].forEach((flash) => {
    if (flash) {
      setTimeout(() => {
        flash.style.display = "none";
      }, 3000);
    }
  });
});
