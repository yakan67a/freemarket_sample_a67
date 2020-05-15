$(function(){
  $(".smallbox").on('mouseover','img',function(){
    let image = $(this).attr('src');
    $(".bigPict").attr('src',image);
  })
})