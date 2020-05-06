$(function(){
  var index = [0,1,2,3,4];
  //削除ボタンクリックした時のアクション
  $(".flexbox").on("click", ".delete-btn", function(){
    var targetIndex = Number($(this).attr("index"));
    var Index = index.push(targetIndex);
    var ReWidth = Index*130
    $("#image-wrapper").attr("for",`item_item_images_attributes_${targetIndex}_image_URL`);
    $(this).parent().remove();
    $(`#item_item_images_attributes_${targetIndex}_image_URL`).remove();
    $(".flexbox").append(`<input class="js-file" type="file" name="item[item_images_attributes][${targetIndex}][image_URL]" id="item_item_images_attributes_${targetIndex}_image_URL">`);
    if(Index == 1){
      $(".form__items__main__image--field").show();
      $(".form__items__main__image--field").css("width",ReWidth);
    }else if(index == 2){
      $(".form__items__main__image--field").css("width",ReWidth);
    }else if(index == 3){
      $(".form__items__main__image--field").css("width",ReWidth);
    }else if(index == 4){
      $(".form__items__main__image--field").css("width",ReWidth);
    }else{
      $(".form__items__main__image--field").css("width",ReWidth);
    }
  })
  //新しいinputタグの生成するための変数
  var buildImage = function(url){
    if(index.length != 0){
      $(".new-wrapper__main__preview").append(`
        <div class="new-wrapper__main__preview__image">
        <img class="new-wrapper__main__preview__image__img" src="${url}">
        <div class="delete-btn" index=${index[0]}><i class="far fa-times-circle"></i></div>
        </div>
      `);
      $(".flexbox").append(`<input class="js-file" type="file" name="item[item_images_attributes][${index[1]}][image_URL]" id="item_item_images_attributes_${index[1]}_image_URL">`);
      $("#image-wrapper").attr("for",`item_item_images_attributes_${index[1]}_image_URL`);
      index.shift();
      var afterWidth = index.length*130
      $(".form__items__main__image--field").css("width",afterWidth);
      if(index.length == 0){
        $(".form__items__main__image--field").hide();
      }
    }
  }
  $(".flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})