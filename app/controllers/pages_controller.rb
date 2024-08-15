class PagesController < ApplicationController
    def home
      @categories = ["Yiyecek-İçecek", "Giyim", "Elektronik", "Sağlık", "Eğlence"]

      if user_signed_in?
        @transactions = current_user.transactions.order(created_at: :desc)
        @income_total = current_user.transactions.where(income: true).sum(:amount)
        @expense_total = current_user.transactions.where(income: false).sum(:amount)
        

        @food_total= current_user.transactions.where(category:"Yiyecek-İçecek").sum(:amount)
        @clothing_total= current_user.transactions.where(category:"Giyim").sum(:amount)
        @electronic_total= current_user.transactions.where(category:"Elektronik").sum(:amount)
        @health_total= current_user.transactions.where(category:"Sağlık").sum(:amount)
        @entertainment_total= current_user.transactions.where(category:"Eğlence").sum(:amount)

        @category_totals = {}
        @categories.each do |category|
          total_amount = current_user.transactions.where(category: category).sum(:amount)
          percentage = (total_amount.to_f / @expense_total * 100).round(2)
          @category_totals[category] = percentage
        end

        @series_data = @category_totals.values
      else
        @transactions = example_transactions
        @income_total = @transactions.select(&:income).sum(&:amount)
        @expense_total = @transactions.reject(&:income).sum(&:amount)
        @food_total = @transactions.select { |t| t.category == "Yiyecek-İçecek" }.sum(&:amount)
        @clothing_total = @transactions.select { |t| t.category == "Giyim" }.sum(&:amount)
        @electronic_total = @transactions.select { |t| t.category == "Elektronik" }.sum(&:amount)
        @health_total = @transactions.select { |t| t.category == "Sağlık" }.sum(&:amount)
        @entertainment_total = @transactions.select { |t| t.category == "Eğlence" }.sum(&:amount)


        @category_totals = {}
        @categories.each do |category|
          total_amount = @transactions.select { |t| t.category == category }.sum(&:amount)
          percentage = (total_amount.to_f / @expense_total * 100).round(2)
          @category_totals[category] = percentage
        end

        @series_data = @category_totals.values
      end

        
    end

    def profile
      @user = current_user
    end

    def about
      @about = About.all
    end

    def report
    end

    private

    def example_transactions
      [
        OpenStruct.new(desc: 'Sample Gelir 1', amount: 100, date: Date.today, income: true),
        OpenStruct.new(desc: 'Sample Gider 1', amount: 50, date: Date.today, category: 'Giyim', income: false),
        OpenStruct.new(desc: 'Sample Gelir 3', amount: 150, date: Date.today, income: true),
        OpenStruct.new(desc: 'Sample Gider 2', amount: 75, date: Date.today, category: 'Sağlık', income: false),
        OpenStruct.new(desc: 'Sample Gelir 5', amount: 200, date: Date.today, income: true),
        OpenStruct.new(desc: 'Sample Gider 3', amount: 75, date: Date.today, category: 'Yiyecek-İçecek', income: false),
        OpenStruct.new(desc: 'Sample Gider 4', amount: 75, date: Date.today, category: 'Eğlence', income: false),
        OpenStruct.new(desc: 'Sample Gider 5', amount: 75, date: Date.today, category: 'Elektronik', income: false)

        
      ]
    end
  end
  