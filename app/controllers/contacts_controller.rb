class ContactsController < ApplicationController
  before_action :authenticate_user!

  def create
    contact_user = User.find(params[:contact_user_id])

    current_user.contacts.create(contact_user: contact_user)

    redirect_to users_path, notice: "Contact added successfully."
  end

  def destroy
    contact = current_user.contacts.find(params[:id])
    contact.destroy

    redirect_to users_path, notice: "Contact removed successfully."
  end
end