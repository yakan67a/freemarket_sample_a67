$(function(){
  let tabs = $(".mypage__main__container__menu__title");
  function tabSwitch() {
    $(".active").removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".mypage__main__container__itemBox__list").removeClass("show").eq(index).addClass("show");
  }
  tabs.click(tabSwitch);
});

// プロフィール編集画面での画像プレビュー表示
$(function(){
  $('.editProfile__main__imgbox--img').change(function(e){
    var file = e.target.files[0];
    var reader = new FileReader();
    if(file.type.indexOf("image") < 0){
      $('.editProfile__main__imgbox').append('<div class=file_error>画像ファイルを指定してください</div>')
      return false;
    }
    reader.onload = (function(file){
      return function(e){
        $(".profile_image").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  })
})