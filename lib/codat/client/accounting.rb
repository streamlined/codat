module Codat
  class Client
    module Accounting # accounting API

      def get_invoices(company_id:)
        get("/companies/#{company_id}/data/invoices")
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

      def get_payments(company_id:)
        get("/companies/#{company_id}/data/payments")
      end

      def get_credit_notes(company_id:)
        get("/companies/#{company_id}/data/creditNotes")
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

      def get_bill_credit_notes(company_id:)
        get("/companies/#{company_id}/data/billCreditNotes")
      end

      def get_journal_entries(company_id:)
        get("/companies/#{company_id}/data/journalEntries")
      end

      def get_journal_entry_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/journalEntries")
      end

      def create_journal_entry(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/journalEntries", body)
      end

      def get_purchase_orders(company_id:)
        get("/companies/#{company_id}/data/purchaseOrders")
      end

      def get_purchase_order_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/purchaseOrders")
      end

      def create_purchase_order(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/purchaseOrders", body)
      end

      def get_customers(company_id:)
        get("/companies/#{company_id}/data/customers")
      end

      def get_customer_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/customers")
      end

      def create_customer(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/customers", body)
      end

      def get_accounts(company_id:)
        get("/companies/#{company_id}/data/accounts")
      end

      def get_account_options(company_id:, connection_id:)
        get("/companies/#{company_id}/connections/#{connection_id}/options/chartOfAccounts")
      end

      def create_account(company_id:, connection_id:, body: {})
        post("/companies/#{company_id}/connections/#{connection_id}/push/accounts", body)
      end
    end
  end
end
