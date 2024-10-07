#!/usr/bin/env ruby


# @module     Clearbooks
# @brief      Handles Ruby idomatic expression of Clear Books SOAP API
module Clearbooks

  # @class    Clearbooks BankStatement model
  # @brief    Used to create new bank statement.
  #
  # @see      https://www.clearbooks.co.uk/support/api/docs/soap/add-bank-statement-lines/
  class BankStatement < Base

    attr_reader :bank_account, :statement_name, :statement_lines

    # @!attribute [r] bank_account
    # Required.
    # @return [Integer]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/add-bank-statement-lines/

    # @!attribute [r] statement_name
    # Optional.
    # @return [String]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/add-bank-statement-lines/

    # @!attribute [r] statement_lines
    # Optional. An array of statement line elements.
    # @return [Array]
    # @see https://www.clearbooks.co.uk/support/api/docs/soap/createpayment/

    # @fn       def initialize data {{{
    # @brief    Constructor for BankStatement model
    #
    # @param    [Hash]     data      Bank Statement attributes. See https://www.clearbooks.co.uk/support/api/docs/soap/add-bank-statement-lines/
    def initialize data
      @bank_account    = data.savon :bank_account
      @statement_name  = data.savon :statement_name
      @statement_lines = data.savon :statement_lines
    end # }}}

    # @fn       def to_savon {{{
    # @brief    Converts given BankStatement (self) to savon readable format
    #
    # @return   [Hash]      Returns self as Savon readable Hash
    def to_savon
      {
        add_bank_statement_lines: {
          :@bank_account   => @bank_account.to_i,
          :@statement_name => @statement_name.to_s,
          :statement_lines => { bank_statement_line: savon_bank_statement_lines }
        }
      }
    end # }}}

    private

    def savon_bank_statement_lines
      @statement_lines.map do |line|
        {
          :@description => line[:description].to_s,
          :@date        => line[:date].to_s,
          :@amount      => line[:amount].to_f
        }
      end
    end

  end # of class BankStatement

end # of module Clearbooks

# vim:ts=2:tw=100:wm=100:syntax=ruby
