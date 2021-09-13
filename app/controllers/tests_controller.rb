class TestsController < ApplicationController
  before_action :set_test, only: %i[ show edit update destroy ]

  # GET /tests or /tests.json
  def index
    @tests = Test.all
    
    require 'uri'
    require 'net/http'
    
    url = URI("https://api.lexigram.io/v2/extract/entities")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Post.new(url)
    request["authorization"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdSI6Imx4ZzphcGkiLCJzYyI6WyJrZzpyZWFkIiwiZXh0cmFjdGlvbjpyZWFkIl0sImFpIjoiYXBpOmEwYjM3ZTFiLTk1ZWUtODg2YS1mMTI2LWUzY2UyZjFiM2M5OCIsInVpIjoidXNlcjo0MGFiNjMwZC1mMmY0LWQwYmMtZGYwZi0xNGZkMWQ3MjIwOGUiLCJpYXQiOjE2MzEzMzA5MDJ9.IhVjlQZH7JKufb9vbqqnuY2xzxG5Eedg4iKrqlhAB9U'
    request["content-type"] = 'application/json'
    request.body = "{\"text\":\"The patient has diabetes\",\"withContext\":true,\"withMatchLogic\":\"ignore-length\",\"withText\":true}"
    
    response = http.request(request)
    puts response.read_body
    @data = JSON.parse(response.read_body)
  end

  # GET /tests/1 or /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests or /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: "Test was successfully created." }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1 or /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: "Test was successfully updated." }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1 or /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: "Test was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_params
      params.require(:test).permit(:name)
    end
end
