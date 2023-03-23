class StudentsController < ApplicationController
rescue_from ActiveRecord::InvalidForeignKey, with: :render_unprocessable_entity_response

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def index
        render json: Student.all, status: :ok
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end
    
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private
    def student_params
        params.permit(:id, :name, :major, :instructor_id, :age)
    end

    def render_unprocessable_entity_response e
        render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
    end

end
