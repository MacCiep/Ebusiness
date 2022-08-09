module Admin
  class OffersController < AdminController
    def destroy
      offer = Offer.find(params[:id])
      if offer.destroy
        render status: :no_content
      else
        render json: { error: offer.errors.full_messages }, status: :bad_request
      end
    end
  end
end
