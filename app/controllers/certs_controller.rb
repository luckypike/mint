class CertsController < ApplicationController
  def index
    authorize Cert
  end
end
