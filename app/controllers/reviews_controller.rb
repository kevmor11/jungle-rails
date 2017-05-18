class ReviewsController < ApplicationController

  before_filter :require_product
  before_filter :authorize

  def create
    # Creating a new review and passing it the incoming params
    @review = @product.reviews.new(review_params)
    # attaching the current user to the review being created
    @review.user = current_user
    # if the review saves, redirect back to the product page
    if @review.save
      redirect_to @review.product, notice: 'Review was created successfully.'
    else
      @product.reload
      render 'products/show'
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])
    if @review.user == current_user
      @review.destroy
    end
    redirect_to product
  end

  private

  # Find the product associated to the review
  def require_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
