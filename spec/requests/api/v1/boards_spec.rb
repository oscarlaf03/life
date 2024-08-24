require 'swagger_helper'

RSpec.describe 'api/v1/boards', type: :request do
  path '/api/v1/boards/{id}/next' do
    post('brings board to it\'s next state') do
      tags 'Board'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'id of the board you want to iterate over', required: true
      parameter name: :times, in: :body, schema: {
        type: :object,
        properties: {
          times: { type: :integer }
        },
        description: "The number of times you want to iterate next if abscent will iteratee just once"
      }, required: false
      twice_example = { "times": 2 }
      request_body_example value: twice_example, name: 'Example to run twice', summary: 'Run next stage two times'

      response(200, 'successful') do
        let(:id) { create(:board, :star_shape).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/boards' do
    get('lists boards') do
      tags 'Board'
      produces 'application/json'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('creates board') do
      tags "Board"
      consumes 'application/json'

      parameter name: :board, in: :body, type: :object, schema: {
        type: :object,
        properties: {
          rows: { type: :integer },
          columns: { type: :integer },
          initial_cells: { type: :array, items: {
            type: :object, properties: {
                row: { type: :integer },
                column: { type: :integer }
              }
            }
          }
        }, required: true
      }
      infinite_loop = {
        "rows": 100,
        "columns": 100,
        "initial_cells": [
          {
              "row": 25,
              "column": 25
          },
          {
              "row": 25,
              "column": 24
          },
          {
              "row": 25,
              "column": 26
          },
          {
              "row": 24,
              "column": 25
          },
          {
              "row": 26,
              "column": 25
          }
        ]
      }
      one_iteration = {
        "rows": 3,
        "columns": 3,
        "initial_cells": [
            {
                "row": 1,
                "column": 1
            },
            {
                "row": 1,
                "column": 3
            },
            {
                "row": 2,
                "column": 2
            },
            {
                "row": 3,
                "column": 1
            },
            {
                "row": 3,
                "column": 3
            }
        ]
      }
      request_body_example value: infinite_loop, name: 'Infinite Loop shape', summary: 'Shape results in an infinite loop'
      request_body_example value: one_iteration, name: 'One iteration shape', summary: 'Shape results in conclusion after just one iteration'
      response(201, 'successful') do
        let(:board) { infinite_loop }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/boards/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('shows board by id') do
      tags 'Board'
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { Board.all.pluck(:id).sample }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
