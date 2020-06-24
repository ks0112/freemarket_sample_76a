require 'rails_helper'

describe User do
  it "ニックネームがないと進めない"do
    user = build(:user, nickname: nil)
    user.valid?
    expect(user.errors[:nickname]).to include("を入力してください")
  end
  it "メールアドレスが誤入力された（正規表現とあっていない）場合は進めない" do
    user = build(:user,email: %w[user@foo..com user_at_foo,org example.user@foo.
      foo@bar_baz.com foo@bar+baz.com])
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end
  it "メールアドレスが誤入力された" do
    user = build(:user,email: %w[user@foo.gmail.com user_at_foo,org example.user@foo.
      foo@bar_baz.com foo@bar+baz.com])
    user.valid?
    expect(user.valid_email?).to eq(nil)
  end

  it "パスワードがない場合は進めない" do
    user = build(:user,password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードは２回入力しない場合は進めない" do
    user = build(:user,password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it "名字が全角で入力されていないと進めない(アルファベットver)" do
    user = build(:user,family_name: "yamada")
    user.valid?
    expect(user.errors[:family_name]).to include("は全角で入力してください")
  end
  it "名字が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
    user = build(:user,family_name: "ﾔﾏﾀﾞ")
    user.valid?
    expect(user.errors[:family_name]).to include("は全角で入力してください")
  end


  it "名前が全角入力されていないと進めない(アルファベットver)" do
    user = build(:user,first_name: "tarou")
    user.valid?
    expect(user.errors[:first_name]).to include("は全角で入力してください")
  end
  it "名前が全角入力されていないと進めない(半角ｶﾀｶﾅver)" do
    user = build(:user,first_name:"ﾀﾛｳ")
    user.valid?
    expect(user.errors[:first_name]).to include("は全角で入力してください")
  end


  it "名字（カナ）が全角で入力されていないと進めない(アルファベットver)" do
    user = build(:user,family_name_kana: "yamada")
    user.valid?
    expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力してください")
  end
  it "名字（カナ）が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
    user = build(:user,family_name_kana: "ﾔﾏﾀﾞ")
    user.valid?
    expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力してください")
  end


  it "名前(カナ)が全角入力されていないと進めない(アルファベットver)" do
    user = build(:user,first_name_kana: "tarou")
    user.valid?
    expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力してください")
  end
  it "名前(カナ)が全角入力されていないと進めない(半角ｶﾀｶﾅver)" do
    user = build(:user,first_name_kana:"ﾀﾛｳ")
    user.valid?
    expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力してください")
  end

  it "名字（カナ）がカタカナで入力されていないと進めない（ひらがなver）" do
    user = build(:user,family_name_kana: "やまだ")
    user.valid?
    expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力してください")
  end
  it "名字（カナ）がカタカナで入力されていないと進めない(漢字ver)" do
    user = build(:user,family_name_kana: "山田")
    user.valid?
    expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力してください")
  end


  it "名前(カナ)がカタカナで入力されていないと進めない(ひらがなver)" do
    user = build(:user,first_name_kana: "たろう")
    user.valid?
    expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力してください")
  end
  it "名前(カナ)がカタカナで入力されていないと進めない(漢字ver)" do
    user = build(:user,first_name_kana:"ﾀﾛｳ")
    user.valid?
    expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力してください")
  end

  it "生年月日が入力されていないと進めない" do
    user = build(:user,birth_day: nil)
    user.valid?
    expect(user.errors[:birth_day]).to include("を入力してください")
  end
end