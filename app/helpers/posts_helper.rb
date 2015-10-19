module PostsHelper
  def create_short_description(description)
    return description[0..197] + "..."
  end
end
