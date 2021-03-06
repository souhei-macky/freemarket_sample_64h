## トップページ
![スクリーンショット 2020-02-24 18 48 23](https://user-images.githubusercontent.com/57378304/75142396-55f21380-5736-11ea-9251-3f84e18fba22.png)

<div align= "center">
  <h2>Fmarket</h2>
</div>

プログラミングスクールTECH::EXPERTの最終課題で某フリーマーケットサービスのクローンサイトを作成しました。約1ヶ月間、5人チームでアジャイル開発を行いました。
<div align="center">
  <img src="https://user-images.githubusercontent.com/57378304/75227004-bcd40300-57f0-11ea-9208-44574f227623.png" width="100" height="100"><img src="https://user-images.githubusercontent.com/57378304/75227045-cf4e3c80-57f0-11ea-9f09-1c6995c6f8d4.png" width="100" height="100"><img src="https://user-images.githubusercontent.com/57378304/75227064-d8d7a480-57f0-11ea-96d3-11bfc1e74bed.png" width="100" height="100"><img src="https://user-images.githubusercontent.com/57378304/75227085-e2610c80-57f0-11ea-90f7-249aacd5f645.png" width="100" height="100"><img src="https://user-images.githubusercontent.com/57378304/75227159-0290cb80-57f1-11ea-8c2e-9c9b5fe1994f.png" width="100" height="100">
</div>

## URL

### http://52.197.131.3/  
### Basic認証をかけています。ご覧の際は以下のIDとPassを入力してください。  

<ul>
  <li>
    Basic認証
    <ul>  
      <li>🆔ID: admin</li>
      <li>🔑Pass: 2222</li>
    </ul>
  </li>
</ul>

## テストユーザー

<ul>
  <li>
    購入者用アカウント
    <ul>
      <li>✉️メールアドレス: buyer64h@gmail.com</li>
      <li>🔑パスワード: buyer64h</li>
    </ul>
  </li>
</ul>

<ul>
  <li>
    💳 購入用カード情報
    <ul>
      <li>番号：4242424242424242</li>
      <li>期限：12/20</li>
      <li>🔑セキュリティコード：123</li>
    </ul>
  </li>
</ul>

<ul>
  <li>
    出品用アカウント
    <ul>
      <li>✉️メールアドレス: sell64h@gmail.com</li>
      <li>🔑パスワード: sell64h *本番環境ではメールアドレスでのログインをお願い致します。</li>
    </ul>
  </li>
</ul>

## 工夫した点(担当箇所より)

<div align= "center">
  <h3>-商品購入-</h3>
</div>

商品の売り切れ表示の実装を致しました。商品購入時に"itemテーブル"の'shoppoing_status'カラムに数字1が付与され、そのアイテムは売り切れで買うことができないように実装致しました。＊（参考）下記、動画とコード  

```ruby
= form_with model: @item, local: true, url: pay_transaction_path(@item), method: :patch do |form|
  = form.hidden_field :shopping_status, value: 1 #itemテーブルに1を付与
```
form入力と同時に下記payアクションが呼び出されitemテープルが更新されます。  

```ruby
def pay
  if @card
    〜省略〜
    @item.update(item_params) #itemデーブルの更新
    redirect_to done_transaction_index_path 
  else
    redirect_to root_path
  end
end
```
![ebdc64e51f4a14355510e4766485f45d](https://user-images.githubusercontent.com/57378304/75235991-7b4b5400-5800-11ea-9c17-a28b56c49492.gif)


<div align= "center">
  <h3>-商品削除-</h3>
</div>

簡単な記述ではありますが、削除時のポップアップはユーザーの押し間違いを防ぐため必須であると思い導入しています。
data{confirm:}でポプアップを出しています。

```ruby
= link_to item_path(@item), method: :delete, data: {confirm: "削除してもよろしいですか？"} do
  .btn-default.btn-gray この商品を削除する
  
```

![6e94bd410972ac5afb980e3f0e94735b](https://user-images.githubusercontent.com/57378304/75237661-12b1a680-5803-11ea-81a2-fe8de5397829.gif)


<div align= "center">
  <h3>-ユーザーの新規登録-</h3>
</div>

クローンサイトの登録画面のように、ウィザード形式を利用し、ページが遷移してもデータを保持できる記述をしました。
下記の記述をし、sessionに入力された値を保持する仕組みです。

```ruby
def sms
  #user.newのformデータをsessionに格納
  session[:nickname] = user_params[:nickname]
  #session(カラム名)  = user_params(カラム名)
  〜省略〜
end
```
<div align= "center">
  <h3>-クレジットカード登録-</h3>
</div>

payjpを利用し、クレジットカードを利用できるようにしました。また、jsを利用し入力データを暗号化しました。クレジットカード番号などはセキュリティの観点からDBに直接保存するのはリスクが高いからです。
下記、登録画面です。

![0d311cf6b5c497d88145e9fdd0d4fab3](https://user-images.githubusercontent.com/57378304/75247557-8a88cc80-5815-11ea-8f59-fd4503f4858a.gif)






# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true, default: “”|
|encrypted_password|string|null: false, default: “”|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|year|string|null: false|
|month|string|null: false|
|day|string|null: false|
|image|text||
|uid|string|null: false|
|provider|string|null: false|
### Association
- has_many :items, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :credit_card, dependent: :destroy
- has_one :address, dependent: :destroy

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|number|string|null: false|
|building|string||
|phone_number|string||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|
### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|price|integer|null: false|
|shopping_status|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brands_category_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|item_condition_id|integer|null: false, foreign_key: true|
|shopping_status|integer|
|delivery_charge|string|
|date|string|
### Association
- has_many :images, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :comments, dependent: :destroy
- belongs_to :user
- belongs_to :category
- belongs_to :brands_category
- belongs_to :size
- belongs_to :content_condition

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :items
### memo
- Gemのancestryを使用する。

## brands_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items

## sizeテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- belongs_to :item

## item_conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- belongs_to :item

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item