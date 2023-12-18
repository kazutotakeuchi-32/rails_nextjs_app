class Api::V1::BaseController < ApplicationController
  include Pagination
  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!
  alias user_signed_in? api_v1_user_signed_in?
end
