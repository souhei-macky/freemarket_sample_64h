
[
  [1,"-"],
  [2,"シャネル"],
  [3,"ナイキ"],
  [4,"ルイ・ヴィトン"],
  [5,"シュプリーム"],
  [6,"アディダス"]
].each do |id,name|
    BrandsCategory.create!({id: id, name: name})
end