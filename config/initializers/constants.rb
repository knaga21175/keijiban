  # 環境変数の読み込み
  # 設定値は .env ファイルに書き込む
  envfile = Rails.root.join(".env")

  if envfile.exist?
    envfile.open("r").each do |line|
      if ((line[0,1] != "#") && (line.presence))
      	key, val = line.split("=", 2)
      	ENV[key] = val.chomp
      end
    end
  end
