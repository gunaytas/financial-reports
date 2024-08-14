class PagesController < ApplicationController
    def home
      @transaction = Transaction.all 
    end

    def profile
    end

    def about
      @abouts= About.first
      @about = About.all
    end

    def report
    end

    
  end
  