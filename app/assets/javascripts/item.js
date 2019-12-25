$(function() {
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
    // .sell-dropbox-containerの配列の最初に追加
    $('.sell-upload-items-container').before(html);
  };

  // アップロードボタンの表示
  function CountPreview() {
    // 画像が10枚の時、アップロードボタンを非表示
    if ($('.preview-box').length == 10) {
      $('.sell-upload-drop-box').css('display', 'none');
    };
  };

  // 画像を入れた時にイベント発火
  $(document).on('change', '.fileup,.fileup_last', function(e){
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
        if ($('.preview-box').length > 10) {
          alert('画像は最大10枚です')
          // 11枚以降のプレビューを全削除
          $('.preview-box').slice(10).remove();
        };
        CountPreview();
      }
    }
  });
  // 黒い削除ボタン(DB未保存の画像)を押すと発火
  $(document).on('click', '.preview-box__select p', function(){
    // 画像削除を容認
    $(this).closest('.preview-box').remove();

    if ($('.preview-box').length < 10) {
      $('.sell-upload-drop-box').css('display', 'block');
    };
  });
  // 赤い削除ボタン(DB保存済の画像)を押すと発火
  $(document).on('click', '.preview-box__select-2 p', function(){
    if (window.location.href.match(/items\/\d+\/edit/)){
      // DB保存済み画像が残り1枚の場合
      if ($('.preview-box__select-2').length == 1) {
        alert('削除できません');
        //画像削除を無効化
        return false;
      } else {
        // 画像削除を容認
        $(this).closest('.preview-box').remove();
        CountPreview();
      };
    };
  });
// 画像投稿をする度にinputを追加する記述
  $(document).on('change', '.fileup,.fileup_last',function(event) {
    let input_area = $('.sell-upload-drop-box');
    let new_input = $(`<input multiple= "multiple" name="images[image][]" class="boxfileselect fileup_last" type="file" accept="image/*">`);
    input_area.prepend(new_input);
    input_area.children(":first").css({'display':'block'});
    // 選択したインプットは消す。
    $(this).css({'display':'none'});    
  });
});
