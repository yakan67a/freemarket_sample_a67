// 出品商品編集画面、商品画像用jsファイル（画像削除ボタン用）
//☓をクリックしたとき、処理が動く。
$(document).on('click','.image-preview_btn_delete',function(){
  var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text"><i class="fas fa-camera"></i><br>クリックして選択<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
  $ul = $('#previews')
  $lis = $ul.find('.image-preview');
  $input = $ul.find('.input');
  $ul = $('#previews')
  $li = $(this).parents('.image-preview');

  $li.remove();

  //inputを新たに表示（プレビューの数により変動）
  $lis = $ul.find('.image-preview');
  $label = $ul.find('.input');
  if($lis.length < 4 ){
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * ${$lis.length}))`
    })
  }
  else if($lis.length == 4 ){
    $ul.append(append_input)
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * ${$lis.length}))`
    })
  }
});