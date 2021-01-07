require 'net/http'
require 'json'

class CalculationsController < ApplicationController
  #global variables
  $fuel_type_list = ["Jet A-1", "Jet B", "AvGas"]
  # based onn https://www.verifavia.com/greenhouse-gas-verification/fq-how-are-aircraft-co2-emissions-calculated-11.php
  $emissions_list = {
    "Jet A-1" => 3.15,
    "Jet B" => 3.10,
    "AvGas" => 3.10
  }

  def new
    @types = @fuel_type_list
    @calculation = Calculation.new
  end

  def create
    @fuel_type = params[:calculation][:fuel_type]
    @weight = params[:calculation][:weight_in_kg].to_i

    # calculate emissions
    @co2 = $emissions_list["#{@fuel_type}"] * @weight

    # get the offsetAPI_id and the SAF price
    offsetAPI_info = request_id_and_price((@co2 * 1000).to_i)
    @offsetAPI_id = offsetAPI_info[:id]
    @price = offsetAPI_info[:price]

    # Calculate SAF weight: 3,15 * 0,8 --> 1kg SAF saves 2,52kg CO2
    @SAF_weight = @co2 / 2.52

    # Save the object
    @calculation = Calculation.new(
      fuel_type: @fuel_type,
      weight_in_kg: @weight,
      CO2_in_kg: @co2,
      SAF_in_kg: @SAF_weight,
      SAF_price_in_EUR: @price,
      offsetAPI_id: @offsetAPI_id
    )
    @calculation.save
  end

  private

  #defines the base parameters needed to call the API
  def base_parameters
    uri = URI('https://api.offset-api.cloud/carbon_activities')
    headers = { 'Content-Type': 'application/json', 'X-API-KEY': 'sk_test_uSTDBzdJPcvEoFvShfYfAE4U' }
    request = Net::HTTP::Post.new(uri, headers)
    [uri, request]
  end

  # is the core of the API request
  def request_id_and_price(co2)
    uri = base_parameters[0]
    request = base_parameters[1]
    request.body = {
      items: [
        {
          carbon_activity_type: "general",
          parameters: {
            co2_amount_in_grams: co2},
        }
      ],
      "project_split": [
        {
          "project_code": "3",
          "percentage": 100
        }
      ]
    }.to_json
    res = get_api_result(uri, request)
    get_id_and_price(res)
  end

  def get_api_result(uri,request)
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def get_id_and_price(result)
    res = JSON.parse(result.body)
    result_hash = {
      id: res["id"],
      price: res["items_results"][0]["price"]
    }
  end
end
