$(function(){
  $("#price__calc").on('input',function(){
    var price = $(this).val();
    var profit = Math.round(price*0.9)
    var fee   = (price - profit)
    $(".result__fee").html(fee);
    $(".result__fee").prepend("¥");
    $(".result__profit").html(profit);
    $(".result__profit").prepend("¥");
    if(profit == ''){
      $(".result__fee").html('');
      $(".result__profit").html('');
    }
  });
})