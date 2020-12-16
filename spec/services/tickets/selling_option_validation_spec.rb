# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tickets::SellingOptionValidation, type: :service do
  RSpec.shared_examples 'raises error' do
    it 'raises error' do
      expect { validate }.to raise_error do |error|
        error.should be_a(Tickets::SellingOptionValidation::Error)
        error.errors.should include(sector.id => msg)
      end
    end
  end

  describe '#validate!' do
    subject(:validate) { described_class.new(event, [{ sector_id: sector.id }], selling_option).validate! }

    let(:event) { create(:event, :with_sector) }
    let(:sector) { event.sectors.first }
    let(:selling_option) { 'avoid_one' }

    it 'returns nil if there are no errors' do
      expect(validate).to be_nil
    end

    context 'when selling option is all' do
      let(:selling_option) { 'all' }
      let(:msg) { 'Not all tickets are passed for the sector.' }

      it_behaves_like 'raises error'
    end

    context 'when selling option is even and wrong amount of tickets was passed' do
      let(:selling_option) { 'event' }
      let(:msg) { 'Amount of tickets should be even for the sector.' }

      it_behaves_like 'raises error'
    end

    context 'when selling option is avoid one' do
      let(:selling_option) { 'avoid_one' }
      let(:msg) { 'You can not pass leave one ticket.' }

      before { sector.update(tickets_amount: 2 ) }

      it_behaves_like 'raises error'
    end

    context 'when selling option is incorrect' do
      let(:selling_option) { 'wrong' }

      it 'raises error' do
        expect { validate }.to raise_error Tickets::SellingOptionValidation::Error,
                                           'There is no such selling option.'
      end
    end
  end
end
