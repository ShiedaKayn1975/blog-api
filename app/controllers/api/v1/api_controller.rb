class Api::V1::ApiController < ApplicationController
  include JSONAPI::ActsAsResourceController
  before_action :authenticate_user!

  def context
    @context = {
      user: current_user,
      base_url: request.base_url
    } unless @context

    @context
  end
end