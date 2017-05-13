class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    # Find the product associated to the review we're creating
    product = Product.find(params[:product_id])
    # Creating a new review and passing it the incoming params
    review = product.reviews.new(review_params)
    # attaching the current user to the review being created
    review.user = current_user
    # if the review saves, redirect back to the product page
    if review.save
      redirect_to product, notice: 'Review was created successfully.'
    else
      redirect_to product_path([:id])
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    review = product.reviews.find(params[:id])
    if review.user == current_user
      review.destroy
    end
    redirect_to product
  end

  private

    def review_params
      params.require(:review).permit(:description, :rating)
    end
end
