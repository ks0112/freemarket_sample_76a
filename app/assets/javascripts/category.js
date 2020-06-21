$(document).on('turbolinks:load', function(){
  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      let childSelectHtml = '';
      childSelectHtml = `<select class="item_input__body__category__children--select" id="child_category" name="item[child_id]">
                           <option value="" data-category="">選択してください</option>
                           ${insertHTML}</select>`;
      $('#children_box').append(childSelectHtml);
    }
    // 孫カテゴリーの表示作成
    function appendGrandchidrenBox(insertHTML){
      let grandchildSelectHtml = '';
      grandchildSelectHtml = `<select class="item_input__body__category__grandchildren--select" id="grandchild_category" name="item[category_id]">
                                <option value="" data-category="">選択してください</option>
                                ${insertHTML}</select>`;
      $('#grandchildren_box').append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $(document).on('change','#parent_category', function(){
      console.log(this)
      let parent_category_id = $('#parent_category').val(); //選択された親カテゴリーの名前を取得
      if (parent_category_id != ""){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'GET',
          data: { parent_name: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          // console.log(this)
          $('#child_category').remove(); //親が変更された時、子以下を削除する
          $('#grandchild_category').remove();
          let insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          $('#child_category').remove();
          $('#grandchild_category').remove();
        })
      }else{
        $('#child_category').remove();
        $('#grandchild_category').remove();
      }
    });
    // 子カテゴリー選択後のイベント
    $(document).on('change', '#child_category', function(){
      let child_category_id = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (child_category_id != ""){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/items/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          // console.log(this)
          if (grandchildren.length != 0) {
            $('#grandchild_category').remove(); //子が変更された時、孫以下を削除する
            let insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          $('#grandchild_category').remove(); //edit時孫の削除
          alert('孫カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
  });
});