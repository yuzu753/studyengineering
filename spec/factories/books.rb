FactoryBot.define do
  factory :book do

    title { "スラスラ読めるRubyふりがなプログラミング" }
    url { 'https://books.rakuten.co.jp/rb/15819130/' }
    book_code { '9784295005902' }
    sales_date { '2019年03月' }
    price { '2200' }
    author { '高橋征義/リブロワークス' }
    caption { '基本をしっかり。目指したのは「究極のやさしさ」。コードを読む力でレール（Ｒａｉｌｓ）を乗りこなそう！！登場するコードに「ふりがな」を。さらに「読み下し文」でフォロー。' }
    review_average { '1.0' }
    review_count { '4.1' }
    small_image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5902/9784295005902.jpg?_ex=64x64' }
    medium_image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5902/9784295005902.jpg' }
    large_image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5902/9784295005902.jpg?_ex=200x200' }
  end
end
