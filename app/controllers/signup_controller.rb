class SignupController < ApplicationController

  def personal
    @user = User.new 
  end

  def sms
    #user.newのformデータをsessionに格納
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:year] = user_params[:year]
    session[:month] = user_params[:month]
    session[:day] = user_params[:day]
    @address = Address.new 
  end

  def residence
    session[:phone_number] = address_params[:phone_number]
    @address = Address.new 
  end

  def create
    @user = User.new(
      nickname: session[:nickname], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name], 
      first_name: session[:first_name], 
      family_name_kana: session[:family_name_kana], 
      first_name_kana: session[:first_name_kana],
      year: session[:year],
      month: session[:month],
      day: session[:day]
    )
    if @user.save
      #trueの場合下記ifの実行
      #falseの場合personalにredirect
      session[:zip_code] = address_params[:zip_code]
      session[:prefectur] = address_params[:prefectur]
      session[:city] = address_params[:city]
      session[:number] = address_params[:number]
      session[:building] = address_params[:building]
      session[:phone_number] = address_params[:phone_number]
      session[:user_id] = @user.id

      @address = Address.new(
        zip_code: session[:zip_code],
        prefectur: session[:prefectur],
        city: session[:city],
        number: session[:number],
        building: session[:building],
        phone_number: session[:phone_number],
        user_id: session[:user_id]
      )

      if @address.save
        #trueの場合@user_idをsessionに格納しdoneへredirect
        #falseの場合residenceにredirect
        session[:id] = @user.id
        redirect_to done_signup_index_path
      else
        redirect_to residence_signup_index_path
      end

    else
      redirect_to personal_signup_index_path
    end
  end

  def done
    #登録したuserでログイン
    sign_in User.find(session[:id]) unless user_signed_in?
  end


  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password,
      :password_confirmation,
      :family_name,
      :first_name, 
      :family_name_kana, 
      :first_name_kana, 
      :year,
      :month,
      :day
    )
  end

  def address_params
    params.require(:address).permit(
      :zip_code,
      :prefectur,
      :city,
      :number,
      :building,
      :phone_number,
      :user_id
    )
  end
end
