class AccountsController < ApplicationController
  def show
    lsp_accout = Graphql.current_account
  end
end
