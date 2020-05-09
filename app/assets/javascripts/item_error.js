$(function(){
  $("form").submit(function(){
    $("p.error").remove();
    
    var imageData = $(".js-file").val();
    if(imageData==""){
      $(".form__items__main__image--field").after("<p class='error'>画像を選択してください</p>");
    }

    var CategoryParentData = $("#list__category__parent").val();
    var CategoryChildData  = $("#list__category__children").val();
    var CategoryGrandData = $("#list__category__grandchildren").val();
    if(CategoryParentData==""){
      $(".form__details__category").after("<p class='error'>選択してください</p>");
      $("#list__category__parent").css({
        "border" : "1px solid red",
      });
    }else if(CategoryChildData=="---"){
      $(".form__details__category").after("<p class='error'>選択してください</p>");
      $("#list__category__children").css({
        "border" : "1px solid red",
      });
    }else if(CategoryGrandData=="0"){
      $(".form__details__category").after("<p class='error'>選択してください</p>");
      $("#list__category__grandchildren").css({
        "border" : "1px solid red",
      });
    }

    var PriceData = $("#price__calc").val();
    if(PriceData==""){
      $("#price__calc").after("<p class='error'>入力してください</p>").css({
        "border" : "1px solid red",
      });
    }
    if(PriceData<300 || PriceData>9999999){
      $("#price__calc").after("<p class='error'>金額を正しく入力してください</p>").css({
        "border" : "1px solid red",
      });
    }
    
    $(".js-file,input[type='text'].validate, textarea.validate, select.validate").
    each(function(){
      if($(this).hasClass("required")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
      if($(this).hasClass("sentence")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
      if($(this).hasClass("condition")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
      if($(this).hasClass("cost")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
      if($(this).hasClass("prefecture")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
      if($(this).hasClass("days")){
        if($(this).val()==""){
          $(this).parent().after("<p class='error'>入力してください</p>");
          $(this).parent().css({
            "border" : "1px solid red",
          });
        }
      }
    });
    if($("p.error").length > 0){
      $('html,body').animate({ scrollTop: $("p.error:first").offset().top-200 },'slow');
      return false;
    }
  });
});