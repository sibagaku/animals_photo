$(function(){
  $("#theTarget").skippr({
    transition: "slide",
    speed: 1000,
    easing: "easeOutQuart",
    navType: "bubble",
    childrenElementType: "div",
    arrows: true,
    autoPlay: true,
    autoPlayDuration: 3000,
    keyboardOnAlways: false,
    hideProvious: true,
  });
});