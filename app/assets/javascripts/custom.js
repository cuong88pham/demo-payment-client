$(".multiple-items").slick({
  infinite: true,
  slidesToShow: 4,
  slidesToScroll: 1,
  prevArrow: $(".prev"),
  nextArrow: $(".next"),
  responsive: [
    {
      breakpoint: 1200,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 1,
        adaptiveHeight: true
      }
    },
    {
      breakpoint: 960,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 1,
        adaptiveHeight: true
      }
    }
  ]
});

$(".btn-action").on("click", function(e) {
  e.preventDefault();
  $(this).addClass("btn-white");
  console.log($(this).attr("id"));
  if ($(this).attr("id") == "buy") {
    $("#sell").removeClass("btn-white");
  } else {
    $("#buy").removeClass("btn-white");
  }
});

$(window).on("scroll", function() {
  if ($(this).scrollTop() > 1000) {
    $("#back-top").fadeIn();
  } else {
    $("#back-top").fadeOut();
  }
});
// scroll body to 0px on click
$("#back-top").on("click", function() {
  $("#back-top").tooltip("hide");
  $("body,html").animate(
    {
      scrollTop: 0
    },
    1500
  );
  return false;
});
