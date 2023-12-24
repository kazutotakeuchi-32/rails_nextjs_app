# README

## ECRにpushする手順
1. 認証トークンを取得し、レジストリに対して Docker クライアントを認証
``` bash
aws ecr get-login-password --region ap-northeast-1 --proofile プロファイル名 | docker login --username AWS --password-stdin url
```

2. ビルドしてイメージを作成
``` bash
docker build -t コンテナ名 -f ファイル名 ディレクトリ
```

3. タグを設定
``` bash
docker tag image_name:latest url/image_name:latest
```

4. push
``` bash
docker push url/image_name:latest
```

## ECSコンテナ接続手順

1. ECSのタスクロールにIAMポリシーをアタッチ
AWS側のコンソールのIAMで設定

``` json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ],
      "Resource": "*"
    }
  ]
}
```

2. サービスに実行権限を付与

``` bash
aws ecs update-service \
    --profile プロファイル名 \
    --cluster クラスタ名 \
    --service サービス名 \
    --enable-execute-command | grep enableExecuteCommand
```


3. コンテナの実行
``` bash
aws ecs execute-command --cluster  \
    --profile プロファイル名 \
    --region リージョン \
    --task タスクID \
    --container コンテナ名 \
    --interactive \
    --command "/bin/sh"
```


## ECSのデプロイフロー
1. コンテナデプロイ用のイメージをビルド
2. ECRにpush
3. タスクを定義もしくは再定義
4. サービスを更新もしくは作成

## AWSCLI

### クラスタの作成

``` bash
aws ecs --profile プロファイル名 create-cluster --cluster-name クラスタ名
```

### クラスタの削除

``` bash
aws ecs --profile プロファイル名  delete-cluster --cluster クラスタ名
```


### サービスの作成

``` bash
aws ecs --profile プロファイル名 create-service \
    --cluster クラスタ名 \
    --service-name サービス名 \
    --enable-execute-command \
    --task-definition タスクARN \
    --desired-count 1 \
    --network-configuration "awsvpcConfiguration={subnets=[サブネットID],securityGroups=[セキュリティグループ]}"
```


### サービスの削除

``` bash
# サービスのスケールダウン
aws ecs update-service \
    --cluster <クラスタ名> \
    --service <サービス名> \
    --desired-count 0

# サービス削除
aws ecs delete-service \
    --cluster クラスタ名 \
    --service サービス名
```

## コンテナ起動

### 通常
``` bash
make up
```

### 本番
``` bash
make prod_up
```

### ssl化
``` bash
make ssl_up
```

