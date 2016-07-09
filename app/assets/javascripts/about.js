$(function(){
  $(".project").mouseover(function(){
    var images = ['flixter.jpeg', 'todo.jpeg', 'gamershaunts.jpeg', 'gameoflife.png'];
    var links = ["https://jt-flixter.herokuapp.com","https://jt-todo.herokuapp.com/","https://jt-gamershound.herokuapp.com","http://codepen.io/tohyung85/full/rxEZKy/"];
    var id = $(this).data("id") - 1;
    var imagePath = "/assets/" + images[id];
    var replacement = "<a href='" + links[id] + "'><img src='" + imagePath + "'/></a>";
    $(".project-image").html(replacement);
  });

});