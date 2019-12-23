require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
	describe '正常にリダイレクトできる' do
    context 'ログインしてるとき' do
    before do
      login_user
      get :index
    end
      it { is_expected.to have_http_status :success }
      it { is_expected.to render_template :index }
      end
    end
    describe '異常リダイレクトできない' do
      context "ユーザーのログインなしで遷移できない" do
        it "GET #index" do
          get :index
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

end
