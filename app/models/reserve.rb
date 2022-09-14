class Reserve < ApplicationRecord
  belongs_to :customer
  
  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, presence: true, uniqueness: true
  
  validate :date_before_start
  validate :date_three_month_end

  def date_before_start
    errors.add(:day, "は過去の日付は選択できません。予約画面から正しい日付を選択してください。") if day < Date.current
  end

  def date_three_month_end
    errors.add(:day, "は3ヶ月以降の日付は選択できません。予約画面から正しい日付を選択してください。") if (Date.current >> 3) < day
  end

  def self.check_reserve_day(day)
    if day < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < day
      return "3ヶ月以降の日付は選択できません。3ヶ月以内の日付を選択してください。"
    end
  end

  def self.reserves_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reserves = Reserve.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    reserve_data = []
    # 配列を作成し、データを格納
    # DBアクセスを減らすために必要なデータを配列に入れている
    reserves.each do |reserve|
      reserves_hash = {}
      reserves_hash.merge!(day: reserve.day.strftime("%Y-%m-%d"), time: reserve.time, name: reserve.customer.last_name, id:reserve.id)
      reserve_data.push(reserves_hash)
    end
    reserve_data
  end
end
