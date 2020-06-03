$(function() {
    


    function buildChildHTML(child){
      var html =`<li><a class="child_category" id="${child.id}" href="/categories/${child.id}/child"></li>${child.name}</a>`;
      return html;
    }
  
    $(".parent_category").on("mouseover", function() {
      var id = this.id
      $(".child_category").remove();
      $(".grand_child_category").remove();
      $.ajax({
        type: 'GET',
        url: '/homes/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildChildHTML(child);
          $(".children_list").append(html);
        })
      });
    });
  
    function buildGrandChildHTML(child){
      var html =`<li><a class="grand_child_category" id="${child.id}"href="/categories/${child.id}/grandchild"></li>${child.name}</a>`;
      return html;
    }
  
    $(document).on("mouseover", ".child_category", function () {
      var id = this.id
      $.ajax({
        type: 'GET',
        url: '/homes/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseover", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });  
  });