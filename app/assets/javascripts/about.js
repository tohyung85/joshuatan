$(function(){
  $("img").on('load', function(){
    //$(this).show();
    //$(this).parent().children(".loading-circle").hide();
  });

  $(".project").mouseover(function(){
    var images = ['flixter.jpeg', 'todo.jpeg', 'gamershaunts.jpeg', 'gameoflife.png'];
    var links = ["https://jt-flixter.herokuapp.com","https://jt-todo.herokuapp.com/","https://jt-gamershound.herokuapp.com","http://codepen.io/tohyung85/full/rxEZKy/"];
    var id = $(this).data("id") - 1;
    var imagePath = "/assets/" + images[id];
    var replacement = "<a href='" + links[id] + "'><img src='" + imagePath + "'/></a>";
    $(".project-image").html(replacement);
    $(".project-image a").append('<div class="loading-circle"><div class="circularGcircle"><div id="circularG_1" class="circularG"></div><div id="circularG_2" class="circularG"></div><div id="circularG_3" class="circularG"></div><div id="circularG_4" class="circularG"></div><div id="circularG_5" class="circularG"></div><div id="circularG_6" class="circularG"></div><div id="circularG_7" class="circularG"></div><div id="circularG_8" class="circularG"></div></div></div>');
      $(".project-image img").on('load', function(){
        $(".project-image img").show();
        $(this).parent().children(".loading-circle").hide();
      });
  });

});