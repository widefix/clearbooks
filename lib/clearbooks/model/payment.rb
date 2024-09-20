#!/usr/bin/env ruby


# @module     Clearbooks
# @brief      Handles Ruby idomatic expression of Clear Books SOAP API
module Clearbooks

  # @class    Clearbooks Payment model
  # @brief    Used to create payments in Clearbooks API
  #
  # @see      https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/
  class Payment < Base

    attr_reader :accounting_date,
                :type,
                :description,
                :amount,
                :entity_id,
                :payment_method,
                :bank_account,
                :invoices


    # @!attribute [r] accounting_date
    # Optional. Date the payment was made.
    # @return [DateTime]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] type
    # Optional. String identifying the type of the payment. Value one of: purchases, sales.
    # @return [String]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] description
    # Optional.
    # @return [String]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] amount
    # Optional. The total amount paid in pounds.
    # @return [BigDecimal]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] entity_id
    # Optional. The id of the customer or supplier.
    # @return [Fixnum]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] payment_method
    # Optional. The id of the payment method.
    # @return [Fixnum]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] bank_account
    # Optional. The account code of the bank account being paid into.
    # @return [String]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @!attribute [r] invoices
    # Optional. An array of invoice elements.
    # @return [Array]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @fn       def initialize data {{{
    # @brief    Constructor for Payment model
    #
    # @param    [Hash]     data      Payment attributes. For the list of available options see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/
    def initialize data
      @accounting_date  = parse_date data.savon :accounting_date
      @type = data.savon :type
      @description = data.savon :description
      @amount = BigDecimal data.savon :amount
      @entity_id = data.savon(:entity_id).to_i
      @payment_method = data.savon(:payment_method).to_i
      @bank_account = data.savon :bank_account
      @invoices = data.savon :invoices
    end # }}}

    # @fn       def to_savon {{{
    # @brief    Converts given Payment (self) to savon readable format
    #
    # @return   [Hash]      Returns self as Savon readable Hash
    def to_savon
      {
          payment: {
              :@accountingDate => @accounting_date.strftime('%F'),
              :@type            => @type,
              :@amount          => @amount.to_f,
              :@entityId       => @entity_id,
              :@paymentMethod  => @payment_method,
              :@bankAccount    => @bank_account,
              :description     => @description,
              :invoices        => { invoice: savon_invoices }
          }
      }
    end # }}}

    private

    def savon_invoices
      @invoices.map do |i|
        {
            :@id      => i[:id],
            :@amount  => i[:amount]
        }
      end
    end

  end # of class Payment

end # of module Clearbooks

# vim:ts=2:tw=100:wm=100:syntax=ruby
