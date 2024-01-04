# インフラ

## terraform

### 初期化
``` bash
terraform init
```

### 設定が有効かどうか確認
``` bash
terraform validate
```

### 設定の確認
``` bash
terraform plan
```

### 設定の反映
``` bash
terraform apply
```

### 削除
``` bash
terraform destroy
```

## ローカル構成
設定ファイルはinfraディレクトリ配下にまとめる。
Dockerファイルは、docker-compose.ymlファイルがあるディレクトリをカレントディレクトリとして
ビルドする。

- mysqlディレクトリ
- nextディレクトリ
- railsディレクトリ
- nginxディレクトリ