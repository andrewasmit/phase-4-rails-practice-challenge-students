class InstructorsController < ApplicationController
rescue_from ActiveRecord::InvalidForeignKey, with: :render_unprocessable_entity_response

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        teacher = Instructor.find(params[:id])
        render json: teacher, status: :ok
    end

    def create
        teacher = Instructor.create!(instructor_params)
        render json: teacher, status: :created
    end

    def destroy
        teacher  = Instructor.find(params[:id])
        teacher.destroy
        head :no_content
    end

    def update
        teacher = Instructor.find(params[:id])
        teacher.update!(instructor_params)
        render json: teacher, status: :accepted
    end

    private
    def instructor_params
        params.permit(:name, :id)
    end

    def render_unprocessable_entity_response
        render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
