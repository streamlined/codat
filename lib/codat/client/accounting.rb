module Codat
  class Client
    module Accounting # accounting API

      def get_invoices(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/invoices", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def create_invoice(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/invoices", body)
      end

      def update_invoice(company_id:, connection_id:, invoice_id:, body: {})
        put("/companies/#{company_id}/connections/#{connection_id}/push/invoices/#{invoice_id}")
      end

      # returns shape of invoice for get and create requests
      def get_invoice_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/invoices")
      end

      # NOTE: on the docs it says this endpoint is deprecated
      def get_invoice(company_id:, invoice_id:)
        get("/companies/#{company_id}/data/invoices/#{invoice_id}")
      end

      # only supported by QB Online
      # def delete_invoice(company_id:, connection_id:, invoice_id:)
      #   delete("/companies/#{company_id}/connections/#{connection_id}/push/invoices/#{invoice_id}")
      # end

      # returns shape of payment for creating a payment
      def get_payment_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/payments")
      end

      def create_payment(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/payments", body)
      end

      def get_payments(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/payments", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_payment(company_id:, payment_id:)
        get("/companies/#{company_id}/data/payments/#{payment_id}")
      end

      def get_credit_notes(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/creditNotes", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      # Credit notes are primarily used for QB.. for NetSuite they use Bill Credit Notes
      def get_credit_note_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/creditNotes")
      end

      def create_credit_note(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/creditNotes", body)
      end

      def get_bill_credit_note(company_id:, bill_credit_note_id:)
        get("/companies/#{company_id}/data/billCreditNotes/#{bill_credit_note_id}")
      end

      def get_bill_credit_note_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/billCreditNotes")
      end

      def create_bill_credit_note(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/billCreditNotes", body)
      end

      def get_bill_credit_notes(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/billCreditNotes", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_journal_entries(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/journalEntries", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_journal_entry_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/journalEntries")
      end

      def create_journal_entry(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/journalEntries", body)
      end

      def get_journal_entry(company_id:, journal_entry_id:)
        get("/companies/#{company_id}/data/journalEntries/#{journal_entry_id}")
      end

      def get_purchase_orders(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/purchaseOrders", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_purchase_order_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/purchaseOrders")
      end

      def create_purchase_order(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/purchaseOrders", body)
      end

      def get_customers(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/customers", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_customer(company_id:, customer_id:)
        get("/companies/#{company_id}/data/customers#{customer_id}")
      end

      def get_customer_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/customers")
      end

      def create_customer(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/customers", body)
      end

      def get_accounts(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/accounts", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_account(company_id:, account_id:)
        get("/companies/#{company_id}/data/accounts/#{account_id}")
      end

      def get_account_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/chartOfAccounts")
      end

      def create_account(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/accounts", body)
      end

      def get_bank_accounts(company_id:, connection_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/connections/#{connection_id}/data/bankAccounts", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_bank_account_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/bankAccounts")
      end

      def create_bank_account(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/bankAccounts", body)
      end

      def get_items(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/items", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_item_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/items")
      end

      def create_item(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/items", body)
      end

      def get_sales_orders(company_id:, order_by: nil, query: nil, page: 1, page_size: 100)
        get("/companies/#{company_id}/data/salesOrders", {
          orderBy: order_by,
          query: query,
          page: page,
          pageSize: page_size
        }.compact)
      end

      def get_sales_orer(company_id:, sales_order_id:)
        get("/companies/#{company_id}/data/salesOrders/#{sales_order_id}")
      end
    end
  end
end
