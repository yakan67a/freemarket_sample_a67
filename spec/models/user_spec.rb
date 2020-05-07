require 'rails_helper'

describe User do
  describe '#create' do
    it "nickname、email、passwordとpassword_confirmation、name_last、name_first、name_last_kana、name_first_kana、birthが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    # ニックネーム
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "") 
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    # メールアドレス
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailに＠がない場合は登録できないこと" do
      user = build(:user, email: "aaaaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailに＠がある場合は登録できる" do
      user = build(:user, email: "test@example.com")
      user.valid?
      expect(user).to be_valid
    end

    it "重複したemailが存在する場合は登録できないこと" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # パスワード
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが6文字以下は登録できないこと" do
      user = build(:user, password: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "passwordが７文字以上であれば登録できること" do
      user = build(:user, password: "1234567")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが2回同じものを入力されない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # 名前
    it "name_lastがない場合は登録できないこと" do
      user = build(:user, name_last: "")
      user.valid?
      expect(user.errors[:name_last]).to include("を入力してください")
    end

    it "name_firstがない場合は登録できないこと" do
      user = build(:user, name_first: "")
      user.valid?
      expect(user.errors[:name_first]).to include("を入力してください")
    end

    # 名前カナ
    it "name_last_kanaがない場合は登録できないこと" do
      user = build(:user, name_last_kana: "")
      user.valid?
      expect(user.errors[:name_last_kana]).to include("を入力してください")
    end

    it "name_last_kanaが全角カタカナの場合は登録できること" do
      user = build(:user, name_last_kana: "タナカ")
      user.valid?
      expect(user).to be_valid
    end

    it "name_last_kanaが全角カタカナでない場合は登録できないこと" do
      user = build(:user, name_last_kana: "tanaka")
      user.valid?
      expect(user.errors[:name_last_kana]).to include("全角カタカナで入力してください")
    end

    it "name_first_kanaがない場合は登録できないこと" do
      user = build(:user, name_first_kana: "")
      user.valid?
      expect(user.errors[:name_first_kana]).to include("を入力してください")
    end

    it "name_last_kanaが全角カタカナの場合は登録できること" do
      user = build(:user, name_first_kana: "タロウ")
      user.valid?
      expect(user).to be_valid
    end

    it "name_last_kanaが全角カタカナでない場合は登録できないこと" do
      user = build(:user, name_first_kana: "taro")
      user.valid?
      expect(user.errors[:name_first_kana]).to include("全角カタカナで入力してください")
    end

    # 生年月日
    it "birthがない場合は登録できないこと" do
      user = build(:user, birth: "")
      user.valid?
      expect(user.errors[:birth]).to include("を入力してください")
    end
  end
end