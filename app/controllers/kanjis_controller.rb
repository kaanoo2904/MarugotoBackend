class KanjisController < ApplicationController
    include ApplicationHelper

    before_action :set_kanji, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    # GET /kanjis
    def index
        #@kanjis = Kanji.all.includes(:lesson)
        #@lessons = [*1..32]
        @lessons_with_kanji = Lesson.kanji_books.with_kanjis.includes(:kanjis)
    end

    # GET /kanjis/1
    def show
        @kanji = Kanji.includes(:examples).find(params[:id])
    end

    # GET /kanjis/new
    def new
        @kanji = Kanji.new(lesson_id: default_kanji_lesson)
    end

    # GET /kanjis/1/edit
    def edit
    end

    # POST /kanjis
    def create
        @kanji = Kanji.new(kanji_params)
        cache_kanji_lesson @kanji.lesson_id
        if @kanji.save
            redirect_to @kanji, flash: {success: 'Grammar was successfully created.'}
        else
            render :new
        end
    end

    # PATCH/PUT /kanjis/1
    # PATCH/PUT /kanjis/1.json
    def update
        if @kanji.update(kanji_params)
            redirect_to @kanji, flash: {success:  "#Kanji {@kanji.kanji} was successfully updated."}
        else
            render :edit
        end
    end

    # DELETE /kanjis/1
    # DELETE /kanjis/1.json
    def destroy
        @kanji.destroy
        respond_to do |format|
            format.html { redirect_to kanjis_url, notice: 'Kanji was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    def search_by_entry_number
        respond_to do |format|
            format.js {
                @result = Kanji.find_by(entry_number: params[:id]) || nil
            }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanji
        @kanji = Kanji.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kanji_params
        params.require(:kanji).permit(:kanji, :entry_number, :meaning, :onyomi, :kunyomi, :stroke_count, :hint, :image, :radical, :lesson_id, examples_attributes: [:id, :_destroy, :sentences, :kanji_version, :meaning, :note])
    end
end
