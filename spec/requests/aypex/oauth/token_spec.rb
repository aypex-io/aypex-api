require 'spec_helper'
require 'digest'

describe 'Aypex OAuth', type: :request do
  let!(:user) { create(:user, email: 'new@user.com', password: 'secret', password_confirmation: 'secret') }
  let(:token) { Aypex::OauthAccessToken.active_for(user).last }
  let(:client_secret) { 'secret' }
  let(:client) { create(:oauth_application, secret: client_secret) }

  describe 'get token' do
    shared_examples 'does not return a token' do
      it do
        expect(response.status).to eq(400)
        expect(json_response[:error]).to eq('invalid_grant')
      end
    end

    shared_examples 'returns a token' do
      it 'with all required attributes' do
        expect(response.status).to eq(200)
        expect(json_response).to have_attributes(%w[access_token token_type expires_in created_at])
        expect(json_response['token_type']).to eq('Bearer')
      end

      it 'returns non encrypted token and stores encrypted version in the database' do
        expect(Digest::SHA256.hexdigest(json_response['access_token'])).to eq(token.token)
      end
    end

    context 'with client credentials' do
      context 'with valid credentials' do
        let(:token) { Aypex::OauthAccessToken.where(application: client).last }

        let(:params) do
          {
            client_id: client.uid,
            client_secret: client_secret,
            grant_type: 'client_credentials',
            scope: 'admin'
          }
        end

        before { post '/aypex_oauth/token', params: params }

        it_behaves_like 'returns a token'

        it 'creates new application token' do
          expect(token.resource_owner_id).to be_nil
          expect(token.resource_owner_type).to be_nil
          expect(token.application).to eq(client)
          expect(token.scopes).to eq(['admin'])
        end
      end

      context 'without client secret' do
        let(:params) do
          {
            client_id: client.uid,
            grant_type: 'client_credentials'
          }
        end

        before { post '/aypex_oauth/token', params: params }

        it { expect(response.status).to eq(401) }
      end
    end

    context 'by password' do
      context 'with client' do
        before do
          allow(Aypex::Config.user_class).to receive(:find_for_database_authentication).with(hash_including(:email)) { user }
          allow(user).to receive(:valid_for_authentication?).and_return(true)
          allow(user).to receive(:active_for_authentication?).and_return(true)
        end

        context 'with valid credentials' do
          let(:params) do
            {
              client_id: client.uid,
              client_secret: client_secret,
              grant_type: 'password',
              username: user.email,
              password: 'secret',
              scope: 'admin'
            }
          end

          before { post '/aypex_oauth/token', params: params }

          it_behaves_like 'returns a token'

          it 'creates new user token tied to application' do
            expect(token.resource_owner_id).to eq(user.id)
            expect(token.resource_owner_type).to eq('Aypex::LegacyUser')
            expect(token.application).to eq(client)
            expect(token.scopes).to eq(['admin'])
          end
        end

        context 'with invalid client credentials' do
          let(:params) do
            {
              client_id: client.uid,
              grant_type: 'password',
              username: user.email,
              password: 'secret',
              scope: 'admin'
            }
          end

          before { post '/aypex_oauth/token', params: params }

          it { expect(response.status).to eq(401) }
        end
      end

      context 'without client, with scopes' do
        let(:params) do
          {
            grant_type: 'password',
            username: user.email,
            password: 'secret',
            scope: 'admin'
          }
        end

        before do
          allow(Aypex::Config.user_class).to receive(:find_for_database_authentication).with(hash_including(:email)) { user }
          allow(user).to receive(:valid_for_authentication?).and_return(true)
          allow(user).to receive(:active_for_authentication?).and_return(true)
          post '/aypex_oauth/token', params: params
        end

        it_behaves_like 'returns a token'

        it 'creates new user token' do
          expect(token.resource_owner_id).to eq(user.id)
          expect(token.resource_owner_type).to eq('Aypex::LegacyUser')
          expect(token.scopes).to eq(['admin'])
        end
      end

      context 'with confirmation' do
        before do
          module Aypex
            module Auth
              class Config
                def self.confirmable
                  self.confirmable = true unless @confirmable == false

                  if @confirmable.in? [true, false]
                    @confirmable
                  else
                    raise 'Aypex::Auth::Config.confirmable MUST be a Boolean (true / false)'
                  end
                end

                def self.confirmable=(key)
                  @confirmable = key
                end
              end
            end
          end

          allow(Aypex::Config.user_class).to receive(:find_for_database_authentication).with(hash_including(:email)) { user }
          allow(user).to receive(:valid_for_authentication?).and_return(true)
          allow(user).to receive(:active_for_authentication?).and_return(active_value)
          post '/aypex_oauth/token?grant_type=password&username=new@user.com&password=secret'
        end

        context 'when the user is confirmed' do
          let(:active_value) { true }

          it 'creates new user token' do
            expect(token.resource_owner_id).to eq(user.id)
            expect(token.resource_owner_type).to eq('Aypex::LegacyUser')
          end

          it_behaves_like 'returns a token'
        end

        context 'when the user is not confirmed' do
          let(:active_value) { false }

          it_behaves_like 'does not return a token'
        end
      end

      context 'user does not exist' do
        before do
          allow(Aypex::Config.user_class).to receive(:find_for_database_authentication).with(hash_including(:email)) { nil }
          post '/aypex_oauth/token?grant_type=password&username=new@user.com&password=secret'
        end

        it_behaves_like 'does not return a token'
      end
    end
  end
end
