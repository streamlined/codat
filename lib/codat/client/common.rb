module Codat
  class Client
    module Common # common API
      # list all companies in codat
      def get_companies
        get("/companies")
      end

      def get_company(company_id: )
        get("/companies/#{company_id}")
      end

      def create_company(
        name: ,
        description:
      )
        post("/companies", {
          name: name,
          description: description
        })
      end

      def get_company_connections(company_id: )
        get("/companies/#{company_id}/connections")
      end

      def get_data_status(company_id: )
        get("/companies/#{company_id}/dataStatus")
      end

      def queue_pull_operations(company_id: )
        post("/companies/#{company_id}/data/all")
      end

      # https://docs.codat.io/codat-api#/operations/create-pull-operation#Path-Parameters
      def queue_pull_operation(company_id:, data_type: )
        post("/companies/#{company_id}/data/queue/#{data_type}")
      end

      def get_push_operation(company_id:, push_operation_id:)
        get("/companies/#{company_id}/push/#{push_operation_id}")
      end

      def get_push_options(company_id:, data_type:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/#{data_type}")
      end
    end
  end
end
