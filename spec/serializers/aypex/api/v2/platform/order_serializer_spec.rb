require "spec_helper"

describe Aypex::Api::V2::Platform::OrderSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :order }

  context "cart" do
    let(:resource) { create(type) }

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
              additional_tax_total: resource.additional_tax_total,
              adjustment_total: resource.adjustment_total,
              approved_at: resource.approved_at,
              canceled_at: resource.canceled_at,
              channel: resource.channel,
              currency: resource.currency,
              completed_at: resource.completed_at,
              confirmation_delivered: resource.confirmation_delivered,
              display_additional_tax_total: resource.display_additional_tax_total.to_s,
              display_adjustment_total: resource.display_adjustment_total.to_s,
              display_outstanding_balance: resource.display_outstanding_balance.to_s,
              display_cart_promo_total: resource.display_cart_promo_total.to_s,
              display_included_tax_total: resource.display_included_tax_total.to_s,
              display_item_total: resource.display_item_total.to_s,
              display_order_total_after_store_credit: resource.display_order_total_after_store_credit.to_s,
              display_pre_tax_item_amount: resource.display_pre_tax_item_amount.to_s,
              display_pre_tax_total: resource.display_pre_tax_total.to_s,
              display_promo_total: resource.display_promo_total.to_s,
              display_ship_total: resource.display_ship_total.to_s,
              display_shipment_total: resource.display_shipment_total.to_s,
              display_store_credit_remaining_after_capture: resource.display_store_credit_remaining_after_capture.to_s,
              display_tax_total: resource.display_tax_total.to_s,
              display_total: resource.display_total.to_s,
              display_total_applicable_store_credit: resource.display_total_applicable_store_credit.to_s,
              display_total_applied_store_credit: resource.display_total_applied_store_credit.to_s,
              display_total_available_store_credit: resource.display_total_available_store_credit.to_s,
              email: resource.email,
              included_tax_total: resource.included_tax_total,
              internal_note: resource.internal_note,
              item_count: resource.item_count,
              item_total: resource.item_total,
              last_ip_address: resource.last_ip_address,
              non_taxable_adjustment_total: resource.non_taxable_adjustment_total,
              number: resource.number,
              payment_state: resource.payment_state,
              payment_total: resource.payment_total,
              private_metadata: {},
              promo_total: resource.promo_total,
              public_metadata: {},
              shipment_state: resource.shipment_state,
              shipment_total: resource.shipment_total,
              special_instructions: resource.special_instructions,
              state: resource.state,
              state_lock_version: resource.state_lock_version,
              store_owner_notification_delivered: resource.store_owner_notification_delivered,
              taxable_adjustment_total: resource.taxable_adjustment_total,
              total: resource.total,
              created_at: resource.created_at,
              updated_at: resource.updated_at
            },
            relationships: {
              adjustments: {
                data: []
              },
              all_adjustments: {
                data: []
              },
              line_items: {
                data: []
              },
              shipments: {
                data: []
              },
              state_changes: {
                data: []
              },
              order_promotions: {
                data: []
              },
              payments: {
                data: []
              },
              reimbursements: {
                data: []
              },
              return_authorizations: {
                data: []
              },
              bill_address: {
                data: {
                  id: resource.bill_address.id.to_s,
                  type: :address
                }
              },
              user: {
                data: {
                  id: resource.user.id.to_s,
                  type: :user
                }
              },
              approver: {data: nil},
              canceler: {data: nil},
              ship_address: {data: nil},
              created_by: {data: nil}
            }
          }
        }
      )
    end

    it_behaves_like "an ActiveJob serializable hash"
  end

  context "completed order" do
    let(:resource) { create(:shipped_order) }

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
              additional_tax_total: resource.additional_tax_total,
              adjustment_total: resource.adjustment_total,
              approved_at: resource.approved_at,
              canceled_at: resource.canceled_at,
              channel: resource.channel,
              currency: resource.currency,
              completed_at: resource.completed_at,
              confirmation_delivered: resource.confirmation_delivered,
              display_additional_tax_total: resource.display_additional_tax_total.to_s,
              display_adjustment_total: resource.display_adjustment_total.to_s,
              display_outstanding_balance: resource.display_outstanding_balance.to_s,
              display_cart_promo_total: resource.display_cart_promo_total.to_s,
              display_included_tax_total: resource.display_included_tax_total.to_s,
              display_item_total: resource.display_item_total.to_s,
              display_order_total_after_store_credit: resource.display_order_total_after_store_credit.to_s,
              display_pre_tax_item_amount: resource.display_pre_tax_item_amount.to_s,
              display_pre_tax_total: resource.display_pre_tax_total.to_s,
              display_promo_total: resource.display_promo_total.to_s,
              display_ship_total: resource.display_ship_total.to_s,
              display_shipment_total: resource.display_shipment_total.to_s,
              display_store_credit_remaining_after_capture: resource.display_store_credit_remaining_after_capture.to_s,
              display_tax_total: resource.display_tax_total.to_s,
              display_total: resource.display_total.to_s,
              display_total_applicable_store_credit: resource.display_total_applicable_store_credit.to_s,
              display_total_applied_store_credit: resource.display_total_applied_store_credit.to_s,
              display_total_available_store_credit: resource.display_total_available_store_credit.to_s,
              email: resource.email,
              included_tax_total: resource.included_tax_total,
              internal_note: resource.internal_note,
              item_count: resource.item_count,
              item_total: resource.item_total,
              last_ip_address: resource.last_ip_address,
              non_taxable_adjustment_total: resource.non_taxable_adjustment_total,
              number: resource.number,
              payment_state: resource.payment_state,
              payment_total: resource.payment_total,
              private_metadata: {},
              promo_total: resource.promo_total,
              public_metadata: {},
              shipment_state: resource.shipment_state,
              shipment_total: resource.shipment_total,
              special_instructions: resource.special_instructions,
              state: resource.state,
              state_lock_version: resource.state_lock_version,
              store_owner_notification_delivered: resource.store_owner_notification_delivered,
              taxable_adjustment_total: resource.taxable_adjustment_total,
              total: resource.total,
              created_at: resource.created_at,
              updated_at: resource.updated_at
            },
            relationships: {
              adjustments: {
                data: []
              },
              all_adjustments: {
                data: []
              },
              line_items: {
                data: [
                  {
                    id: resource.line_items.first.id.to_s,
                    type: :line_item
                  }
                ]
              },
              shipments: {
                data: [
                  {
                    id: resource.shipments.first.id.to_s,
                    type: :shipment
                  }
                ]
              },
              state_changes: {
                data: []
              },
              order_promotions: {
                data: []
              },
              payments: {
                data: [
                  {
                    id: resource.payments.first.id.to_s,
                    type: :payment
                  }
                ]
              },
              reimbursements: {
                data: []
              },
              return_authorizations: {
                data: []
              },
              bill_address: {
                data: {
                  id: resource.bill_address.id.to_s,
                  type: :address
                }
              },
              user: {
                data: {
                  id: resource.user.id.to_s,
                  type: :user
                }
              },
              approver: {data: nil},
              canceler: {data: nil},
              ship_address: {
                data: {
                  id: resource.ship_address.id.to_s,
                  type: :address
                }
              },
              created_by: {data: nil}
            }
          }
        }
      )
    end

    it_behaves_like "an ActiveJob serializable hash"
  end
end
