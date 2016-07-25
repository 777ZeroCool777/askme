module UsersHelper

  # метод для склонения вопросов
  def question_sklonyator(question)
    ostatok = question.size % 10

    ostatok100 = question.size % 100 # исключения для цифр от 11 до 14 родительный падеж (Кого? Чего?)

    if question.size == 0
      "Нет вопросов"
    elsif ostatok100 >= 11 && ostatok100 <= 14
      "#{question.size} вопросов"
    elsif ostatok == 1
      "#{question.size} вопрос"
    elsif ostatok >= 2 && ostatok <= 4
      "#{question.size} вопроса"
    elsif ostatok > 4 || ostatok == 0
      "#{question.size} вопросов"
    end
  end


  def destroy
    "Трали-вали"
  end

end
