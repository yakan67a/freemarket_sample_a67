// 出品商品編集画面、商品画像用jsファイル

$(function(){
  // 編集ページ読み込み時：保存画像のプレビュー表示とファイル選択エリア表示
  var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
  $ul = $('#previews')
  $lis = $ul.find('.image-preview');
  $input = $ul.find('.input');
  if($input.length == 0){
    if($lis.length <= 3 ){
      $ul.append(append_input)
      $('#previews .input').css({
        'width': `calc(100% - (20% * ${$lis.length}))`
      })
    }
    else if($lis.length == 4 ){
      $ul.append(append_input)
      $('#previews .input').css({
        'width': `100%`
      })
    }
  }

  // ファイル選択をクリック時の動き
  $(document).on('click', '.image_upload', function(){
    var preview = $(`<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_edit">編集</div><div class="image-preview_btn_delete">削除</div></div>`); 
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $li = $(this).parents('li');
    $label = $(this).parents('.upload-label');
    $inputs = $ul.find('.image_upload');
    
    //inputの画像の読み込み時プレビュー表示
    $('.image_upload').on('change', function (e) {
      var reader = new FileReader();
      reader.readAsDataURL(e.target.files[0]);

      //inputで読み込んだ画像をimgタグに追加 
      reader.onload = function(e){
        $(preview).find('.preview').attr({
          width: "100px",
          height: "100px",
          src: e.target.result
        });
      }

      //画像を付与した,previewを$liに追加。
      $li.append(preview);

      //プレビュー完了後、inputを非表示
      $label.css('display','none');
      $li.removeClass('input');
      $li.addClass('image-preview');
      $lis = $ul.find('.image-preview');
      $('#previews li').css({
        'width': `114px`
      })

      //inputを新たに表示（プレビューの数により変動）
      if($lis.length <= 3 ){
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * ${$lis.length}))`
        })
      }
      else if($lis.length == 4 ){
        $li.addClass('image-preview');
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `100%`
        })
      }

      //inputの最後の"data-image"を取得して、input nameの番号を更新
      $inputs.each( function( num, input ){
        $(input).removeAttr('name');
        $(input).attr({
          name:"item[item_images_attributes][" + num + "][image_URL]",
          id:"item_item_images_attributes_" + num + "_image_URL"
        });
      });
    });
  });
});