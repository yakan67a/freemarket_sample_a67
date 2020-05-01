$(function(){

  function buildHTML(data) {
    var html = `<option value="${data.id}">${data.name}</option>`;
    return html;
  }



  $("#list__category__parent").on('change',function(){
    var ParentData = $(this).val();
    if (ParentData != '---'){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: {parent_id: ParentData},
        dataType: 'json'
      })
      .done(function(children){
        $(".form__details__category--children").remove();
        $(".form__details__category--grandchildren").remove();
        var insertHTML = `  <div class="form__details__category--children">
                            <select id="list__category__children" name="item[category_id]">
                                <option valuse=0>---</option>`;
        children.forEach(function(child){
          insertHTML += buildHTML(child)
        });
        insertHTML += `</select>
                      </div>
                      `
        $(".form__details__category").append(insertHTML);
      })
      .fail(function(){
        alert('エラーが出ました');
      })
    }
  });

  $(".form__details__category").on('change','#list__category__children',function(){
    var ChildData = $(this).val();
    if (ChildData != "---"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: {child_id: ChildData},
        dataType: 'json'
      })
      .done(function(grandchildren){
        $(".form__details__category--grandchildren").remove();
        var InsertHTML = `<div class="form__details__category--grandchildren">
        <select id="list__category__grandchildren" name="item[category_id]">
          <option value=0>---</option>`;
        grandchildren.forEach(function(grandchild){
          InsertHTML += buildHTML(grandchild)
        });
        InsertHTML += `</select>
                        </div>`
        $('.form__details__category').append(InsertHTML);
      })
      .fail(function(){
        alert("エラーがでました");
      })
    }
  });
});