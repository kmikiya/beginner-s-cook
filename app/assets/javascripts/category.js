$(document).ready(function () {
  // 親カテゴリーを表示
  $('#categoBtn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    $('#tree_menu').show();
    $('.categoryTree').show();
  }, function () {
    // あえて何も記述しない
  });



  // カテゴリー一覧ページのボタン
  $('#all_btn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    $(".categoryTree-grandchild").hide();
    $(".categoryTree-child").hide();
    $(".category_grandchild").remove();
    $(".category_child").remove();
  }, function () {
    // あえて何も記述しないことで親要素に外れた際のアクションだけを伝搬する
  });

  // カテゴリーを非表示(カテゴリーメニュから0.8秒以上カーソルを外したら消える)

  // カテゴリーボタンの処理
  $(document).on({
    mouseenter: function (e) {
      e.stopPropagation();
      e.preventDefault();
      timeOpened = setTimeout(function () {
        $('#tree_menu').show();
        $('.categoryTree').show();
      }, 500);
    },
    mouseleave: function (e) {
      e.stopPropagation();
      e.preventDefault();
      clearTimeout(timeOpened);
      $(".categoryTree-grandchild").hide();
      $(".categoryTree-child").hide();
      $(".categoryTree").hide();
      $("#tree_menu").hide();
      $(".category_child").remove();
      $(".category_grandchild").remove();
    }
  }, '.header__headerInner__nav__listsLeft__item');
});