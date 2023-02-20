// this function open the side bar
function open_sidebar() {
  var sideBar = document.getElementById("sidebar");
  if (sideBar.style.width == "50vw") sideBar.style.width = "0px";
  else sideBar.style.width = "50vw";
}
// this make the nav bar dissappear on scroll down and reappear on scroll up
// this fuction is disabaled if the side bar is open
var prevScrollpos = window.pageYOffset;
window.onscroll = function () {
  var currentScrollPos = window.pageYOffset;
  if (!(document.getElementById("sidebar").style.width == "50vw")) {
    if (prevScrollpos > currentScrollPos) {
      document.getElementById("navbar").style.top = "0";
      document.getElementById("menu-icon").style.top = "35px";
    } else {
      document.getElementById("navbar").style.top = "-70px";
      document.getElementById("menu-icon").style.top = "-35px";
    }
  }
  prevScrollpos = currentScrollPos;
};
