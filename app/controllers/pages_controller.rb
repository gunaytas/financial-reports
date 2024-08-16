class PagesController < ApplicationController
    
    def home
      if user_signed_in?
        perform_calculations(current_user.transactions)
        @transactions = current_user.transactions.order(date: :desc)
      else  
        @transactions = example_transactions
        perform_calculations(@transactions)
      end
    end
 
    def profile
      @user = current_user
    end

    def about
      @about = About.all
    end

    def report
      if user_signed_in?
        perform_calculations(current_user.transactions)
      else
        example_trans = example_transactions
        perform_calculations(example_trans)
      end
      @total = @income_total - @expense_total 
   
    end

    private

    def perform_calculations(transactions)
      @categories = ["Yiyecek-İçecek", "Giyim", "Elektronik", "Sağlık", "Eğlence"]
      @category_totals = {}
      @category_amount = {}
      if user_signed_in?
        @transactions = current_user.transactions.order(created_at: :desc)
        
        @income_total = current_user.transactions.where(income: true).sum(:amount)
        @expense_total = current_user.transactions.where(income: false).sum(:amount)
        
        @categories.each do |category|
          total_amount = current_user.transactions.where(category: category).sum(:amount)
          @category_amount[category] = total_amount
          percentage = (total_amount.to_f / @expense_total * 100).round(2)
          @category_totals[category] = percentage
        end

        @series_data = @category_totals.values
        @monthly_income = current_user.transactions.where(income: true).group_by_month(:date, format: "%B").sum(:amount).sort.to_h
        @monthly_expense = current_user.transactions.where(income: false).group_by_month(:date, format: "%B").sum(:amount).sort.to_h
      else
        @transactions = example_transactions
        @income_total = @transactions.select(&:income).sum(&:amount)
        @expense_total = @transactions.reject(&:income).sum(&:amount)
        
        @categories.each do |category|
          total_amount = @transactions.select { |t| t.category == category }.sum(&:amount)
          @category_amount[category] = total_amount
          percentage = (total_amount.to_f / @expense_total * 100).round(2)
          @category_totals[category] = percentage
        end

        @series_data = @category_totals.values
        
      end
      @months = Date::MONTHNAMES.compact 
      
      

    end

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
  