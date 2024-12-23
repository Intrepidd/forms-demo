class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
  end

  def new
    @form = FeedbackForm.new(Feedback.new)
  end

  def create
    @form = FeedbackForm.new(Feedback.new)

    return if intercept_refresh(:new)

    if @form.submit(params[:feedback])
      redirect_to feedbacks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @feedback = Feedback.find(params[:id])
    @form = FeedbackForm.new(@feedback)
  end

  def update
    @feedback = Feedback.find(params[:id])
    @form = FeedbackForm.new(@feedback)

    return if intercept_refresh(@form, :edit, params[:feedback])

    if @form.submit(params[:feedback])
      redirect_to feedbacks_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy!

    redirect_to feedbacks_path
  end

  private
  def intercept_refresh(form, template, form_params)
    if params[:refresh_form]
      form.assign_form_attributes(form_params)
      render template, status: :unprocessable_entity
      true
    end
  end
end
