RSpec.describe Codat::Client::Accounting do
  let!(:client) {
    Codat::Client.new(
      api_base_url: "https://api.codat.io"
    )
  }

  let(:company_id) { "9c355f96-c981-4e03-b261-b9ea74ac82cc" }
  let(:invoice_id) { "65d7f614-1935-4e73-8d50-da40dc05303d" }
  let(:connection_id) { "1a115249-f359-4a2f-a842-54480549c52f" } # invoices connection


  context 'methods' do
    describe 'get_invoices' do
      it 'should return a list of invoices with the correct attributes' do
        VCR.use_cassette('get_invoices') do
          response = client.get_invoices(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          company = response[0]
          expect(company).to be_a(Hash)
          expect(company).to have_key("id")
          expect(company).to have_key("invoiceNumber")
          expect(company).to have_key("customerRef")
          expect(company).to have_key("issueDate")
          expect(company).to have_key("dueDate")
          expect(company).to have_key("lineItems")
          expect(company).to have_key("totalAmount")
          expect(company).to have_key("totalTaxAmount")
          expect(company).to have_key("amountDue")
        end
      end
    end

    describe 'create_invoice' do
      let(:body) do
        {
          "invoiceNumber": "18/04 15.26",
          "note": "invoice push 20230418 15.26",
          "customerRef": {
            "id": "80000002-1674552702",
            "companyName": "Test Customer 1"
          },
          "salesOrderRefs": [
            {
              "id": "string",
              "dataType": "string"
            }
          ],
          "issueDate": "2023-04-18T11:09:01.438Z",
          "dueDate": "2023-05-24T11:09:01.438Z",
          "modifiedDate": "2023-02-14T11:09:01.438Z",
          "sourceModifiedDate": "2023-02-14T11:09:01.438Z",
          "paidOnDate": "2023-02-10T11:09:01.438Z",
          "currency": "USD",
          "currencyRate": 1,
          "lineItems": [
            {
              "description": "lineItems.description 1",
              "unitAmount": 15,
              "quantity": 2,
              "discountAmount": 0,
              "subTotal": 30,
              "taxAmount": 0,
              "totalAmount": 30,
              "accountRef": {
                "id": "80000006-1671793811",
                "name": "Consulting Income"
              },
              "discountPercentage": 0,
              "taxRateRef": {
                "id": "80000002-1671793802",
                "name": "Non (TAX CODE)",
                "effectiveTaxRate": 0
              },
              "itemRef": {
                "id": "80000004-1675280003",
                "name": "test income item 1"
              },
              "trackingCategoryRefs": [
                {
                  "id": "80000004-1674554660",
                  "name": "Class 3"
                }
              ]
            }
          ],
          "paymentAllocations": [
            {
              "payment": {
                "id": "80000004-1789341990",
                "note": "string",
                "reference": "string",
                "accountRef": {
                  "id": "string",
                  "name": "string"
                },
                "currency": "USD",
                "currencyRate": 1,
                "paidOnDate": "2023-02-14T11:09:01.438Z",
                "totalAmount": 725
              },
              "allocation": {
                "currency": "USD",
                "currencyRate": 1,
                "allocatedOnDate": "2023-02-14T11:09:01.438Z",
                "totalAmount": 725
              }
            }
          ],
          "withholdingTax": [
            {
              "name": "string",
              "amount": 0
            }
          ],
          "totalDiscount": 0,
          "subTotal": 30,
          "additionalTaxAmount": 0,
          "additionalTaxPercentage": 0,
          "totalTaxAmount": 0,
          "totalAmount": 30,
          "amountDue": 87326532,
          "discountPercentage": 0,
          "status": "Submitted"
        }
      end

      it 'should return an invoice with the correct attributes' do
        VCR.use_cassette('create_invoice') do
          response = client.create_invoice(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("invoiceNumber")
          expect(response).to have_key("customerRef")
          expect(response).to have_key("issueDate")
          expect(response).to have_key("dueDate")
          expect(response).to have_key("lineItems")
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("amountDue")
        end
      end
    end

    describe 'update_invoice' do
      let(:body) do
        {
          "id": "string",
          "invoiceNumber": "string",
          "customerRef": {
            "id": "string",
            "companyName": "string"
          },
          "salesOrderRefs": [
            {
              "id": "string",
              "dataType": "string"
            }
          ],
          "issueDate": "2022-10-23T00:00:00.000Z",
          "dueDate": "2022-10-23T00:00:00.000Z",
          "paidOnDate": "2022-10-23T00:00:00.000Z",
          "currency": "GBP",
          "currencyRate": 0,
          "lineItems": [
            {
              "description": "string",
              "unitAmount": 0,
              "quantity": 0,
              "discountAmount": 0,
              "subTotal": 0,
              "taxAmount": 0,
              "totalAmount": 0,
              "accountRef": {
                "id": "string",
                "name": "string"
              },
              "discountPercentage": 0,
              "taxRateRef": {
                "id": "string",
                "name": "string",
                "effectiveTaxRate": 0
              },
              "itemRef": {
                "id": "string",
                "name": "string"
              },
              "trackingCategoryRefs": [
                {
                  "id": "string",
                  "name": "string"
                }
              ],
              "tracking": {
                "categoryRefs": [
                  {
                    "id": "string",
                    "name": "string"
                  }
                ],
                "customerRef": {
                  "id": "string",
                  "companyName": "string"
                },
                "projectRef": {
                  "id": "string",
                  "name": "string"
                },
                "isBilledTo": "Unknown",
                "isRebilledTo": "Unknown"
              },
              "isDirectIncome": true
            }
          ],
          "paymentAllocations": [
            {
              "payment": {
                "id": "string",
                "note": "string",
                "reference": "string",
                "accountRef": {
                  "id": "string",
                  "name": "string"
                },
                "currency": "GBP",
                "currencyRate": 0,
                "paidOnDate": "2022-10-23T00:00:00.000Z",
                "totalAmount": 0
              },
              "allocation": {
                "currency": "GBP",
                "currencyRate": 0,
                "allocatedOnDate": "2022-10-23T00:00:00.000Z",
                "totalAmount": 0
              }
            }
          ],
          "withholdingTax": [
            {
              "name": "string",
              "amount": 0
            }
          ],
          "totalDiscount": 0,
          "subTotal": 0,
          "additionalTaxAmount": 0,
          "additionalTaxPercentage": 0,
          "totalTaxAmount": 0,
          "totalAmount": 0,
          "amountDue": 0,
          "discountPercentage": 0,
          "status": "Unknown",
          "note": "string",
          "metadata": {
            "isDeleted": true
          },
          "modifiedDate": "2022-10-23T00:00:00.000Z",
          "sourceModifiedDate": "2022-10-23T00:00:00.000Z"
        }
      end

      it 'should return an invoice with the correct attributes' do
        VCR.use_cassette('update_invoice') do
          response = client.update_invoice(company_id: company_id, connection_id: connection_id, invoice_id: "string", body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("id")
          expect(response).to have_key("lineItems")
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("amountDue")
        end
      end
    end

    describe 'get_invoice_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_invoice_options') do
          response = client.get_invoice_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'get_invoice' do
      let(:invoice_id) { "65d7f614-1935-4e73-8d50-da40dc05303d" }

      it 'should return an invoice with the correct attributes' do
        VCR.use_cassette('get_invoice') do
          response = client.get_invoice(company_id: company_id, invoice_id: invoice_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("issueDate")
          expect(response).to have_key("lineItems")
          expect(response).to have_key("paymentAllocations")
          expect(response).to have_key("withholdingTax")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("amountDue")
          expect(response).to have_key("status")
        end
      end
    end

    describe 'get_payment_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_payment_options') do
          response = client.get_payment_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'get_payments' do
      it 'should return a list of payments with the correct attributes' do
        VCR.use_cassette('get_payments') do
          response = client.get_payments(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("customerRef")
          expect(response).to have_key("accountRef")
          expect(response).to have_key("currency")
        end
      end
    end

    describe 'create_payment' do
      let(:body) do
        {
          "customerRef": {
            "id": "80000002-1674552702",
            "companyName": "string"
          },
          "accountRef": {
            "id": "8000002E-1675267199",
            "name": "Undeposited Funds"
          },
          "paymentMethodRef": {
            "id": "string",
            "name": "string"
          },
          "totalAmount": 28,
          "currency": "USD",
          "currencyRate": 1,
          "date": "2023-02-10T11:47:04.792Z",
          "note": "note 14/02 1147",
          "lines": [
            {
              "amount": 28,
              "links": [
                {
                  "type": "Invoice",
                  "id": "181-1676374586",
                  "amount": -28,
                  "currencyRate": 1
                }
              ],
              "allocatedOnDate": "2023-02-11T11:47:04.792Z"
            }
          ],
          "reference": "ref 14/02 1147"
        }
      end

      it 'should return a payment with the correct attributes' do
        VCR.use_cassette('create_payment') do
          response = client.create_payment(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("customerRef")
          expect(response).to have_key("accountRef")
          expect(response).to have_key("currency")
        end
      end
    end

    describe 'get_credit_notes' do
      it 'should return a list of credit_notes with the correct attributes' do
        VCR.use_cassette('get_credit_notes') do
          response = client.get_credit_notes(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalDiscount")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("discountPercentage")
          expect(response).to have_key("remainingCredit")
          expect(response).to have_key("status")
        end
      end
    end


    describe 'get_credit_note_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_credit_note_options') do
          response = client.get_credit_note_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_credit_note' do
      let(:body) do
        {
          "creditNoteNumber": "09/03 17.15",
          "note": "credit note 20230309 17.15",
          "status": "Submitted",
          "customerRef": {
            "id": "80000002-1674552702"
          },
          "currency": "USD",
          "currencyRate": 1,
          "subTotal": 10.2,
          "issueDate": "2023-03-09T02:21:26.726327+00:00",
          "lineItems": [
            {
              "itemRef": {
                "id": "80000004-1675280003",
                "name": "test income item 1"
              },
              "quantity": 1,
              "subTotal": 1.25,
              "taxAmount": 0,
              "unitAmount": 1.25,
              "description": "banana",
              "totalAmount": 1.25
            }
          ],
          "totalAmount": 1.25,
          "totalDiscount": 0,
          "totalTaxAmount": 0,
          "discountPercentage": 0,
          "remainingCredit": 0
        }
      end

      it 'should return a credit note with the correct attributes' do
        VCR.use_cassette('create_credit_note') do
          response = client.create_credit_note(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalDiscount")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("discountPercentage")
          expect(response).to have_key("remainingCredit")
          expect(response).to have_key("status")
        end
      end
    end

    describe 'get_bill_credit_note' do
      let(:bill_credit_note_id) { "6a0e9dfb-87b0-47d3-aaaf-9753ae9e757d" }

      it 'should return a bill credit note with the correct attributes' do
        VCR.use_cassette('get_bill_credit_note') do
          response = client.get_bill_credit_note(company_id: company_id, bill_credit_note_id: bill_credit_note_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalDiscount")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("discountPercentage")
          expect(response).to have_key("remainingCredit")
          expect(response).to have_key("status")
          expect(response).to have_key("lineItems")
        end
      end
    end

    describe 'get_bill_credit_note_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_bill_credit_note_options') do
          response = client.get_bill_credit_note_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_bill_credit_note' do
      let(:body) do
        {
          "id": "6a0e9dfb-87b0-47d3-aaaf-9753ae9e757d",
          "billCreditNoteNumber": "14763237",
          "totalAmount": 693,
          "remainingCredit": 693,
          "status": "Submitted",
          "issueDate": "2019-02-18T16:03:07.268Z",
          "note": "Track separately",
          "currency": "USD",
          "lineItems": [
            {
              "description": "AcmeMagnet",
              "unitAmount": 25,
              "discountAmount": 0,
              "quantity": 4,
              "subTotal": 100,
              "taxAmount": 10,
              "totalAmount": 110,
              "itemRef": {
                "id": "3"
              },
              "taxRateRef": {
                "id": "6c88aff3-7cb9-4980-a3d3-443e72e02498"
              },
              "accountRef": {
                "id": "3f267b10-757d-44c0-bef9-20f70cc8fbe3"
              },
              "trackingCategoryRefs": [
                {
                  "id": "department_1",
                  "name": "ACMERockets"
                },
                {
                  "id": "costcode_2",
                  "name": "ACM2-ACMESigns"
                }
              ]
            },
            {
              "description": "ACMEDisintegratingPistol",
              "unitAmount": 25,
              "discountAmount": 0,
              "quantity": 3,
              "subTotal": 75,
              "taxAmount": 7.5,
              "totalAmount": 82.5,
              "itemRef": {
                "id": "3abf0883-03f7-44c6-bc15-1372522d25e1"
              },
              "taxRateRef": {
                "id": "6c88aff3-7cb9-4980-a3d3-443e72e02498"
              },
              "accountRef": {
                "id": "3f267b10-757d-44c0-bef9-20f70cc8fbe3"
              }
            },
            {
              "description": "ACMEWhippedCreamDispenser",
              "unitAmount": 52,
              "discountAmount": 0,
              "quantity": 6,
              "subTotal": 312,
              "taxAmount": 31.2,
              "totalAmount": 343.2,
              "itemRef": {
                "id": "3691f3d9-0ff7-4358-8a93-bed31c1b4b03"
              },
              "taxRateRef": {
                "id": "6c88aff3-7cb9-4980-a3d3-443e72e02498"
              },
              "accountRef": {
                "id": "3f267b10-757d-44c0-bef9-20f70cc8fbe3"
              }
            },
            {
              "description": "ACMEJetPropelledPogoStick",
              "unitAmount": 130,
              "discountAmount": 0,
              "quantity": 1,
              "subTotal": 130,
              "taxAmount": 27.3,
              "totalAmount": 157.3,
              "itemRef": {
                "id": "075410d4-7edc-4936-ba52-9e1e43cbe300"
              },
              "taxRateRef": {
                "id": "d606732b-db18-44d7-823b-7f15f42c32ea"
              },
              "accountRef": {
                "id": "3f267b10-757d-44c0-bef9-20f70cc8fbe3"
              }
            }
          ],
          "supplierRef": {
            "id": "67C6A7A1-5E84-4AC4-B950-24A114E379D0",
            "supplierName": "Chin's Gas and Oil"
          }
        }
      end

      it 'should return a bill credit note with the correct attributes' do
        VCR.use_cassette('create_bill_credit_note') do
          response = client.create_bill_credit_note(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalDiscount")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("discountPercentage")
          expect(response).to have_key("remainingCredit")
          expect(response).to have_key("status")
        end
      end
    end

    describe 'get_bill_credit_notes' do
      it 'should return a list of bill credit notes with the correct attributes' do
        VCR.use_cassette('get_bill_credit_notes') do
          response = client.get_bill_credit_notes(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("totalDiscount")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("discountPercentage")
          expect(response).to have_key("remainingCredit")
          expect(response).to have_key("status")
          expect(response).to have_key("lineItems")
        end
      end
    end

    describe 'get_journal_entries' do
      it 'should return a list of journal entries with the correct attributes' do
        VCR.use_cassette('get_journal_entries') do
          response = client.get_journal_entries(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("id")
          expect(response).to have_key("postedOn")
          expect(response).to have_key("createdOn")
          expect(response).to have_key("journalRef")
          expect(response).to have_key("journalLines")
          expect(response).to have_key("recordRef")
        end
      end
    end

    describe 'get_journal_entry_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_journal_entry_options') do
          response = client.get_journal_entry_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_journal_entry' do
      let(:body) do
        {
          "description": "record level description",
          "postedOn": "2023-02-23T19:49:16.052Z",
          "createdOn": "2023-02-22T19:49:16.052Z",
          "updatedOn": "2023-02-21T19:49:16.052Z",
          "journalRef": {
            "id": "12"
          },
          "journalLines": [
            {
              "description": "journalLines.description debit",
              "netAmount": 23.02,
              "currency": "USD",
              "accountRef": {
                "id": "80000019-1671793811",
                "name": "Office Supplies"
              },
              "tracking": {
                "recordRefs": [
                  {
                    "id": "80000001-1674553252",
                    "dataType": "string"
                  }
                ]
              }
            },
            {
              "description": "journalLines.description credit",
              "netAmount": -23.02,
              "currency": "USD",
              "accountRef": {
                "id": "8000001E-1671793811",
                "name": "Utilities"
              },
              "tracking": {
                "recordRefs": [
                  {
                    "id": "80000002-1674553271",
                    "dataType": "trackingCategories"
                  }
                ]
              }
            }
          ],
          "recordRef": {
            "id": "string",
            "dataType": "string"
          },
          "metadata": {
            "isDeleted": true
          }
        }
      end

      it 'should return a journal entry with the correct attributes' do
        VCR.use_cassette('create_journal_entry') do
          response = client.create_journal_entry(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("id")
          expect(response).to have_key("postedOn")
          expect(response).to have_key("createdOn")
          expect(response).to have_key("journalRef")
          expect(response).to have_key("journalLines")
          expect(response).to have_key("recordRef")
        end
      end
    end

    describe 'get_purchase_orders' do
      it 'should return a list of purchase orders with the correct attributes' do
        VCR.use_cassette('get_purchase_orders') do
          response = client.get_purchase_orders(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("purchaseOrderNumber")
          expect(response).to have_key("issueDate")
          expect(response).to have_key("paymentDueDate")
          expect(response).to have_key("expectedDeliveryDate")
          expect(response).to have_key("deliveryDate")
          expect(response).to have_key("shipTo")
          expect(response).to have_key("supplierRef")
          expect(response).to have_key("status")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("lineItems")
        end
      end
    end

    describe 'get_purchase_order_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_purchase_order_options') do
          response = client.get_purchase_order_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_purchase_order' do
      let(:body) do
        {
          "id": "7e2380af-b51f-4393-92d7-6ff0382da26c",
          "purchaseOrderNumber": "89443280",
          "issueDate": "2020-10-24T00:00:00Z",
          "deliveryDate": "2021-02-02T00:00:00Z",
          "expectedDeliveryDate": "2021-01-29T00:00:00Z",
          "paymentDueDate": "2021-09-13T00:00:00Z",
          "note": "purchaseorder with 1 line items, totalling 1138.5",
          "supplierRef": {
            "id": "7ff6add1-b0e7-496f-b655-48e20c8fdb2e",
            "supplierName": "Carlton Innovations"
          },
          "shipTo": {
            "contact": {
              "name": "Carlton Innovations",
              "email": "sales@carltoninnov.com",
              "phone": ""
            },
            "address": {
              "type": "Billing",
              "line1": "1 Carolyns Circle",
              "line2": "",
              "city": "Dallas",
              "region": "Texas",
              "country": "USA",
              "postalCode": "511210"
            }
          },
          "status": "Closed",
          "currency": "GBP",
          "currencyRate": 1,
          "lineItems": [
            {
              "description": "Electric Eye purchase",
              "accountRef": {
                "id": "13931cbf-ea06-4d6e-9538-a8457fa66011",
                "name": "Cost of Goods Sold"
              },
              "itemRef": {
                "id": "9409d23d-1011-432e-98a4-591fcd8d5404",
                "name": "ACME Electric Eye"
              },
              "trackingCategoryRefs": [],
              "unitAmount": 115,
              "quantity": 9,
              "discountAmount": 0,
              "discountPercentage": 0,
              "subTotal": 1035,
              "taxAmount": 103.5,
              "taxRateRef": {
                "id": "6c88aff3-7cb9-4980-a3d3-443e72e02498",
                "name": "ACME Sales Tax (10%)"
              },
              "totalAmount": 1138.5
            }
          ],
          "totalDiscount": 0,
          "subTotal": 1035,
          "totalTaxAmount": 103.5,
          "totalAmount": 1138.5,
          "modifiedDate": "2020-11-17T21:11:20Z",
          "sourceModifiedDate": "2020-10-25T06:37:33Z"
        }
      end

      it 'should return a purchase order with the correct attributes' do
        VCR.use_cassette('create_purchase_order') do
          response = client.create_purchase_order(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("purchaseOrderNumber")
          expect(response).to have_key("issueDate")
          expect(response).to have_key("paymentDueDate")
          expect(response).to have_key("expectedDeliveryDate")
          expect(response).to have_key("deliveryDate")
          expect(response).to have_key("shipTo")
          expect(response).to have_key("supplierRef")
          expect(response).to have_key("status")
          expect(response).to have_key("subTotal")
          expect(response).to have_key("totalTaxAmount")
          expect(response).to have_key("totalAmount")
          expect(response).to have_key("lineItems")
        end
      end
    end

    describe 'get_customers' do
      it 'should return a list of customers with the correct attributes' do
        VCR.use_cassette('get_customers') do
          response = client.get_customers(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("customerName")
          expect(response).to have_key("contactName")
          expect(response).to have_key("emailAddress")
          expect(response).to have_key("defaultCurrency")
          expect(response).to have_key("phone")
          expect(response).to have_key("addresses")
          expect(response).to have_key("contacts")
        end
      end
    end

    describe 'get_customer_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_customer_options') do
          response = client.get_customer_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_customer' do
      let(:body) do
        {
          "id": "string",
          "customerName": "test",
          "contactName": "string",
          "emailAddress": "string",
          "defaultCurrency": "GBP",
          "phone": "string",
          "addresses": [
            {
              "type": "Unknown",
              "line1": "string",
              "line2": "string",
              "city": "string",
              "region": "string",
              "country": "string",
              "postalCode": "string"
            }
          ],
          "contacts": [
            {
              "name": "string",
              "email": "string",
              "phone": [
                {
                  "number": "+44 25691 154789",
                  "type": "Primary"
                }
              ],
              "address": {
                "type": "Unknown",
                "line1": "string",
                "line2": "string",
                "city": "string",
                "region": "string",
                "country": "string",
                "postalCode": "string"
              },
              "status": "Unknown",
              "modifiedDate": "2022-10-23T00:00:00.000Z"
            }
          ],
          "registrationNumber": "string",
          "taxNumber": "string",
          "status": "Unknown",
          "metadata": {
            "isDeleted": true
          },
          "modifiedDate": "2022-10-23T00:00:00.000Z",
          "sourceModifiedDate": "2022-10-23T00:00:00.000Z"
        }
      end

      it 'should return a customer with the correct attributes' do
        VCR.use_cassette('create_customer') do
          response = client.create_customer(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("customerName")
          expect(response).to have_key("contactName")
          expect(response).to have_key("emailAddress")
          expect(response).to have_key("defaultCurrency")
          expect(response).to have_key("phone")
          expect(response).to have_key("addresses")
          expect(response).to have_key("contacts")
        end
      end
    end

    describe 'get_accounts' do
      it 'should return a list of accounts with the correct attributes' do
        VCR.use_cassette('get_accounts') do
          response = client.get_accounts(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("status")
          expect(response).to have_key("isBankAccount")
        end
      end
    end

    describe 'get_account_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_account_options') do
          response = client.get_account_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_account' do
      let(:body) do
        {
          "id": "1b6266d1-1e44-46c5-8eb5-a8f98e03124e",
          "nominalCode": "610",
          "name": "Accounts Receivable",
          "description": "Invoices the business has issued but has not yet collected payment on.",
          "fullyQualifiedCategory": "Asset.Current",
          "fullyQualifiedName": "Asset.Current.Accounts Receivable",
          "currency": "GBP",
          "currentBalance": 0,
          "type": "Asset",
          "status": "Active",
          "isBankAccount": true,
          "validDatatypeLinks": [
            {
              "property": "string",
              "links": [
                "string"
              ]
            }
          ],
          "metadata": {
            "isDeleted": true
          },
          "modifiedDate": "2022-10-23T00:00:00.000Z",
          "sourceModifiedDate": "2022-10-23T00:00:00.000Z"
        }
      end

      it 'should return an account with the correct attributes' do
        VCR.use_cassette('create_account') do
          response = client.create_account(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("status")
          expect(response).to have_key("isBankAccount")
        end
      end
    end

    describe 'get_bank_accounts' do
      it 'should return a list of bank accounts with the correct attributes' do
        VCR.use_cassette('get_bank_accounts') do
          response = client.get_bank_accounts(company_id: company_id, connection_id: connection_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("accountName")
          expect(response).to have_key("accountType")
          expect(response).to have_key("nominalCode")
        end
      end
    end

    describe 'get_bank_account_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_bank_account_options') do
          response = client.get_bank_account_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_bank_account' do
      let(:body) do
        {
          "id": "string",
          "accountName": "string",
          "accountType": "Unknown",
          "nominalCode": "string",
          "sortCode": "string",
          "accountNumber": "string",
          "iBan": "string",
          "currency": "GBP",
          "balance": 0,
          "institution": "string",
          "availableBalance": 0,
          "overdraftLimit": 0,
          "metadata": {
            "isDeleted": true
          },
          "modifiedDate": "2022-10-23T00:00:00.000Z",
          "sourceModifiedDate": "2022-10-23T00:00:00.000Z"
        }
      end

      it 'should return a bank account with the correct attributes' do
        VCR.use_cassette('create_bank_account') do
          response = client.create_bank_account(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("accountName")
          expect(response).to have_key("accountType")
          expect(response).to have_key("nominalCode")
        end
      end
    end

    describe 'get_items' do
      it 'should return a list of items with the correct attributes' do
        VCR.use_cassette('get_items') do
          response = client.get_items(company_id: company_id)["results"]
          expect(response).to be_a(Array)
          response = response[0]
          expect(response).to be_a(Hash)
          expect(response).to have_key("itemStatus")
          expect(response).to have_key("type")
          expect(response).to have_key("isBillItem")
          expect(response).to have_key("isInvoiceItem")
        end
      end
    end

    describe 'get_item_options' do
      it 'should return expected data for the request payload' do
        VCR.use_cassette('get_item_options') do
          response = client.get_item_options(company_id: company_id, connection_id: connection_id)
          expect(response).to be_a(Hash)
          expect(response).to have_key("type")
          expect(response).to have_key("displayName")
          expect(response).to have_key("properties")
          expect(response).to have_key("required")
        end
      end
    end

    describe 'create_item' do
      let(:body) do
        {
          "id": "string",
          "accountName": "string",
          "accountType": "Unknown",
          "nominalCode": "string",
          "sortCode": "string",
          "accountNumber": "string",
          "iBan": "string",
          "currency": "GBP",
          "balance": 0,
          "institution": "string",
          "availableBalance": 0,
          "overdraftLimit": 0,
          "metadata": {
            "isDeleted": true
          },
          "modifiedDate": "2022-10-23T00:00:00.000Z",
          "sourceModifiedDate": "2022-10-23T00:00:00.000Z"
        }
      end

      it 'should return an item with the correct attributes' do
        VCR.use_cassette('create_item') do
          response = client.create_item(company_id: company_id, connection_id: connection_id, body: body)["data"]
          expect(response).to be_a(Hash)
          expect(response).to have_key("itemStatus")
          expect(response).to have_key("type")
          expect(response).to have_key("isBillItem")
          expect(response).to have_key("isInvoiceItem")
        end
      end
    end
  end
end
