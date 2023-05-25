require "spec_helper"

describe Aypex::Api::V2::Platform::CountrySerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :country }
  let(:resource) { create(type, states: create_list(:state, 2)) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {
            self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
          },
          attributes: {
            iso_name: resource.iso_name,
            iso: resource.iso,
            iso3: resource.iso3,
            name: resource.name,
            numcode: resource.numcode,
            states_required: resource.states_required,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            zipcode_required: resource.zipcode_required
          },
          relationships: {
            states: {
              data: [
                {
                  id: resource.states.first.id.to_s,
                  type: :state
                },
                {
                  id: resource.states.second.id.to_s,
                  type: :state
                }
              ]
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
