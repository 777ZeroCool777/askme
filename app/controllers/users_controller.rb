class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vladislav',
        username: 'installero',
        avatar_url: 'http://cs605624.vk.me/v605624120/5c44/Oi6Rz6NOBn4.jpg'
      ),
      User.new(
        id: 2,
        name: 'Valera',
        username: 'REmiX'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vladislav',
      username: 'installero',
      avatar_url: 'http://cs605624.vk.me/v605624120/5c44/Oi6Rz6NOBn4.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('12.06.2016')),
      Question.new(text: 'В чём смысл жизни?', created_at: Date.parse('12.06.2016'))
    ]

    @new_question = Question.new
  end
end
