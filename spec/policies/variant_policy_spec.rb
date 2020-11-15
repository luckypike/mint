require 'rails_helper'

describe VariantPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }

  permissions :all? do
    it 'grants access for all' do
      expect(subject).to permit(anonymous_user, Order)
    end
  end
end
