// turbolinksを先に読み込む
$(document).on('turbolinks:load', function() {
  // 画像を管理するための配列を定義する。
  var images = [];
  // htmlを定義
  function buildHTML(imgSrc){
    var html =  `<div class="preview-box">
                  <div class="preview-box__img-box">
                    <img src="${imgSrc}", height=118, width=118, class="image">
                  </div>
                  <div class="preview-box__select">
                      <p>削除</p>
                  </div>
                </div>`
    // .dropzoneの配列の最初に追加
    $('.sell-dropbox-container').prepend(html);
  };

  // アップロードボタンの表示
  function CountPreview() {
    // 画像が10枚の時、アップロードボタンを非表示
    if ($('.preview-box__select p').length == 10) {
      $('.sell-upload-drop-box').css('display', 'none');
    };
  };

  // 画像を入れた時にイベント発火
  $('.fileup_last').on("change", function(e){
    // イベント発火したファイルを定義
    var files = e.target.files;
    // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
    for (var i = 0, f; f = files[i]; i++){
      // FileReaderを新しく作成し、定義したreaderに返す
      let reader = new FileReader();
      reader.readAsDataURL(f);
      reader.onload = function(){
        let imgSrc = reader.result;
        // htmlの呼び出し
        buildHTML(imgSrc);
        images.push(imgSrc);
        if ($('.preview-box__select p').length > 10) {
          alert('画像は最大10枚です')
          // 11枚以降のプレビューを全削除
          $('.preview-box').slice(10,).remove();
        };
        CountPreview();
      }
    }
  });
  // 削除ボタンを押すと発火
  $(document).on('click', '.preview-box__select p', function(){
  // 商品投稿ページの場合
    if (window.location.href.match(/items\/new/)){
    // 画像削除を容認
    $(this).closest('.preview-box').remove();
    } else {
    // 商品編集ページの場合
    if (window.location.href.match(/items\/\d+\/edit/)){
      // 画像が残り1枚の場合
      if ($('.preview-box__select p').length == 1) {
        alert('削除できません');
        //画像削除を無効化
        return false;
      } else {
        // 画像削除を容認
        $(this).closest('.preview-box').remove();
      };
    };
    };
    if ($('.preview-box__select p').length < 10) {
      $('.sell-upload-drop-box').css('display', 'block');
    };
  });

// 画像投稿をする度にinputを追加する記述
  let input_area = $('.sell-upload-drop-box');
  $(document).on('change', '.fileup,.fileup_last',function(event) {
    var new_input = $(`<input multiple= "multiple" name="images[image][]" class="boxfileselect fileup" type="file" accept="image/*">`);
    input_area.prepend(new_input);
  });
  
  if (window.location.href.match(/items\/\d+\/edit/)){
    CountPreview();
  };
});