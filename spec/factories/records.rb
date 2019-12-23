FactoryBot.define do
  factory :record do

    user_id { 1 }
    title { 'Udmeyの動画視聴' }
    body { 'JSを勉強する' }
    studytime { 11 }
    until_today_studytime { 100 }
  end
end
