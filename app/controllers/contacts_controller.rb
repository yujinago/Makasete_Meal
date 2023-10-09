class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.send_mail(@contact, current_user).deliver
      flash[:notice] = "お問い合わせ内容を送信しました。"
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def index
    redirect_to new_contact_path
  end

  private

  def contact_params
    params.require(:contact).permit(:nickname, :email, :content)
  end
end
