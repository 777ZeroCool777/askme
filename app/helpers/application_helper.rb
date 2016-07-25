module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end


  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # метод для склонения вопросов
  def questions
    ostatok = @questions.size % 10

    ostatok100 = @questions.size % 100 # исключения для цифр от 11 до 14 родительный падеж (Кого? Чего?)

    if @questions.size == 0
      "Нет вопросов"
    elsif ostatok100 >= 11 && ostatok100 <= 14
      "#{@questions.size} вопросов"
    elsif ostatok == 1
      "#{@questions.size} вопрос"
    elsif ostatok >= 2 && ostatok <= 4
      "#{@questions.size} вопроса"
    elsif ostatok > 4 || ostatok == 0
      "#{@questions.size} вопросов"
    end
  end

end
