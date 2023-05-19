require "spec_helper"

describe Aypex::Api::V2::Platform::ReturnItemSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :return_item }

  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoints.
          attributes: {
            acceptance_status: resource.acceptance_status,
            acceptance_status_errors: resource.acceptance_status_errors,
            additional_tax_total: resource.additional_tax_total,
            display_pre_tax_amount: resource.display_pre_tax_amount.to_s,
            display_total: resource.display_total.to_s,
            included_tax_total: resource.included_tax_total,
            pre_tax_amount: resource.pre_tax_amount,
            reception_status: resource.reception_status,
            resellable: resource.resellable,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            exchange_inventory_units: {
              data: []
            },
            exchange_variant: {
              data: nil
            },
            override_reimbursement_type: {
              data: nil
            },
            preferred_reimbursement_type: {
              data: nil
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
