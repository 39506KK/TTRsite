module Public::ReservesHelper
  def times
    times = ["9:00",
             "10:00",
             "11:00",
             "13:00",
             "14:00",
             "15:00",
             "16:00",
             "17:00",
             "18:00",
             "19:00",
             "20:00",
             "21:00",]
  end
  
  def check_reserve(reserves, day, time)
    result = false
    reserves_count = reserves.count
    # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返す
    if reserves_count > 1
      reserves.each do |reserve|
        result = reserve[:day].eql?(day.strftime("%Y-%m-%d")) && reserve[:time].eql?(time)
        return result if result
      end
    elsif reserves_count == 1
      result = reserves[0][:day].eql?(day.strftime("%Y-%m-%d")) && reserves[0][:time].eql?(time)
      return result if result
    end
    return result
  end
  
end
