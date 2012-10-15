class String
  def to_uah
    a = self.split('.').map!{|x| x.to_f}
    a[1] = 0.00 if a[1].nil?
    a[0].nil? ? 0 : (a[0] * 100 + a[1])/100
  end
end