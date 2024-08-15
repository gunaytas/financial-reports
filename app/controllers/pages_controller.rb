class PagesController < ApplicationController
  before_action :authenticate_user!
    def home
      @transaction = current_user.transactions
    end

    def profile
      @user = current_user
    end

    def about
      @about = About.all
    end

    def report
    end

  end
  