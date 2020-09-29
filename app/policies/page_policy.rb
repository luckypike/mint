PagePolicy = Struct.new :user, :page do
  def index?
    true
  end

  def robots?
    index?
  end

  def contacts?
    index?
  end

  def instagram?
    index?
  end

  def about?
    index?
  end
end
