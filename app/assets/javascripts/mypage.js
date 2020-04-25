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