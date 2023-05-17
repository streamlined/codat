RSpec.describe Codat::Client::Common do
  let!(:client) {
    Codat::Client.new(
      api_base_url: "https://api.codat.io"
    )
  }

  let(:company_id) { "9c355f96-c981-4e03-b261-b9ea74ac82cc" }
  let(:connection_id) { "1a115249-f359-4a2f-a842-54480549c52f" } # invoices connection

  context 'methods' do
    describe 'get_companies' do
      it 'should return a list of companies with the correct attributes' do
        VCR.use_cassette('get_companies') do
          company_list = client.get_companies["results"]
          expect(company_list).to be_a(Array)
          company = company_list[0]
          expect(company).to be_a(Hash)
          expect(company).to have_key("id")
          expect(company).to have_key("name")
          expect(company).to have_key("platform")
          expect(company).to have_key("redirect")
          expect(company).to have_key("lastSync")
          expect(company).to have_key("dataConnections")
          expect(company).to have_key("created")
        end
      end
    end

    describe 'get_company' do
      it 'should return a company with the correct attributes' do
        VCR.use_cassette('get_company') do
          company = client.get_company(company_id: company_id)
          expect(company).to be_a(Hash)
          expect(company).to have_key("id")
          expect(company).to have_key("name")
          expect(company).to have_key("platform")
          expect(company).to have_key("redirect")
          expect(company).to have_key("lastSync")
          expect(company).to have_key("dataConnections")
          expect(company).to have_key("created")
        end
      end
    end

    describe 'create_company' do
      it 'should return a company with the correct attributes' do
        VCR.use_cassette('create_company') do
          company = client.create_company(name: 'API test company', description: "Rspec test company")
          expect(company).to be_a(Hash)
          expect(company).to have_key("id")
          expect(company).to have_key("name")
          expect(company).to have_key("description")
          expect(company).to have_key("platform")
          expect(company).to have_key("redirect")
        end
      end
    end

    describe 'get_company_connections' do
      it 'should return a list of connections with the correct attributes' do
        VCR.use_cassette('get_company_connections') do
          connections_list = client.get_company_connections(company_id: company_id)["results"]
          expect(connections_list).to be_a(Array)
          connection = connections_list[0]
          expect(connection).to be_a(Hash)
          expect(connection).to have_key("id")
          expect(connection).to have_key("integrationId")
          expect(connection).to have_key("platformName")
          expect(connection).to have_key("sourceType")
          expect(connection).to have_key("sourceId")
        end
      end
    end

    describe 'get_data_status' do
      it 'should return status of data' do
        VCR.use_cassette('get_data_status') do
          data_status = client.get_data_status(company_id: company_id)
          expect(data_status).to be_a(Hash)
          expect(data_status).to have_key("bankTransactions")
          expect(data_status).to have_key("bankAccounts")
          expect(data_status).to have_key("invoices")
          expect(data_status).to have_key("bills")
        end
      end
    end

    describe 'queue_pull_operations' do
      it 'should return an empty response for successful queueing of pull' do
        VCR.use_cassette('queue_pull_operations') do
          response = client.queue_pull_operations(company_id: company_id)
          # should start a job, if response there is probably an error
          expect(response).to be_nil
        end
      end
    end

    describe 'queue_pull_operation' do
      it 'should return a pull operation response' do
        VCR.use_cassette('queue_pull_operation') do
          response = client.queue_pull_operation(company_id: company_id, data_type: "invoices")
          expect(response).to be_a(Hash)
          expect(response).to have_key("id")
          expect(response).to have_key("companyId")
          expect(response).to have_key("dataType")
          expect(response).to have_key("status")
          expect(response).to have_key("isCompleted")
          expect(response).to have_key("isErrored")
        end
      end
    end

    describe 'get_push_options' do
      it 'should return a pull operation response' do
        VCR.use_cassette('get_push_options') do
          response = client.get_push_options(company_id: company_id, data_type: "invoices", connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("properties")
          expect(response).to have_key("description")
        end
      end
    end
  end
end
