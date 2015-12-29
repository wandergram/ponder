class PinsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_pin, only: [:show, :edit, :update, :destroy]

	# tweaked the index method to ensure all pins private by default
	# no one but the user can see the user's pins

	def index
		if params[:tag]
			@pins = current_user.pins.tagged_with(params[:tag]).order "created_at DESC"
		else
			@pins = current_user.pins.order "created_at DESC" 
		end
	end

	def show
		@pin = current_user.pins.find params[:id]
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "Success! Pin added."
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Success! Pin updated."
		else
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :address, :tag_list)
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end

end
