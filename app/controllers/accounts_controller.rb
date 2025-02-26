class AccountsController < ApplicationController
  before_action :set_account, only: :show

  def show
    render json: @account
  end

  private

  def set_account
    lsp_accout = Graphql.current_account
    unless Account.exists?(lightspark_id: lsp_account.account_id)
      Account.create!(
        lightspark_id: lsp_account.account_id,
        account_name: lsp_accout.account_name,
        account_created_at: lsp_accout.account_created_at,
        account_updated_at: lsp_accout.account_updated_at
      )
    end
    @account = Account.find_by lightspark_id: lsp_account.account_id
  end
end
