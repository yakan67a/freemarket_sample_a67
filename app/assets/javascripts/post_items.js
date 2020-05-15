$(function(){
  var index = [0,1,2,3,4];
  // ページ読み込み時に画像が何個あるかカウントしてインプットエリアを非表示にする
  var imgCount = $('.new-wrapper__main__preview__image').length
  if(imgCount == 5){
    $(".form__items__main__image--field").hide();
  }

  //削除ボタンクリックした時のアクション
  $(".flexbox").on("click", ".delete-btn", function(){
    var targetIndex = Number($(this).attr("index"));
    var Index = index.push(targetIndex);
    $("#image-wrapper").attr("for",`item_item_images_attributes_${targetIndex}_image_URL`);
    $(this).parent().remove();
    $(`#item_item_images_attributes_${targetIndex}_image_URL`).remove();
    $(".flexbox").append(`<input class="js-file" type="file" name="item[item_images_attributes][${targetIndex}][image_URL]" id="item_item_images_attributes_${targetIndex}_image_URL">`);
    $(".form__items__main__image--field").show();
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
      var imgCount = $('.new-wrapper__main__preview__image').length
      var inputWidth = `calc(100% - (130 * ${imgCount}))`
      $(".form__items__main__image--field").css({'width': inputWidth})
      if(imgCount == 5){
        $(".form__items__main__image--field").hide();
      }
    }
  }
  $(".flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})