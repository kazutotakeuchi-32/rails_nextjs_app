# AWSのインフラ構成

## VPC

| 名前 | IPv4/CIDR|
|--|--|
| zenn-test-vpc | 10.0.0.0/16 |


## サブネット

 名前 | IPv4/CIDR| VPC |
|--|--|--|
| zenn-test-public-subnet1 | 10.0.1.0/24 | zenn-test-vpc |
| zenn-test-public-subnet2 | 10.0.2.0/24 | zenn-test-vpc |
| zenn-test-public-subnet1 | 10.0.100.0/24 | zenn-test-vpc |
| zenn-test-public-subnet2 | 10.0.101.0/24 | zenn-test-vpc |


- パブリックサブネット×2
- プライベートサブネット×2

## インターネットゲートウェイ（Igw）
| 名前 | アタッチVPC|
|--|--|
| zenn-test-gw | zenn-test-vpc|


## セキュリティグループ

### バックエンド

#### インバウンドルール

|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|http| Tcp |80|Ipv4|0.0.0.0/0|
|http| Tcp |80|Ipv6|::/0|


#### アウトバウンドルール
|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|全てのトラフィック| Tcp |80|Ipv4|カスタム|


### フロントエンド
#### インバウンドルール

|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|http| Tcp |80|Ipv4|0.0.0.0/0|
|http| Tcp |80|Ipv6|::/0|


#### アウトバウンドルール
|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|全てのトラフィック| Tcp |80|Ipv4|カスタム|



### ELB
#### インバウンドルール

|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|http| Tcp |80|Ipv4|0.0.0.0/0|
|http| Tcp |80|Ipv6|::/0|
|https| Tcp |443|Ipv4|0.0.0.0/0|
|https| Tcp |443|Ipv6|::/0|


#### アウトバウンドルール
|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|http Tcp |80|Ipv4|カスタム|バックエンドまたはフロントエンドのセキュリティグループ|


### RDS
#### インバウンドルール

|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|Mysql/Aurora| Tcp |3306|カスタム|バックエンドセキュリテイグループ|


#### アウトバウンドルール
|タイプ|プロトコル|ポート|カスタム| 送信先 |
|--|--|--|--|--|
|全てのトラフィック| Tcp |80|Ipv4|カスタム|


## ルートテーブル

### パブリックサブネット
| IPv4/CIDR | ターゲット|
|--|--|
|0.0.0.0/0|igw|
|10.0.0.0/16|local|


- 10.0.0.0 ~ 10.0.255.254までは同VPCでローカル通信
- それ以外はigwを経由してインタネットに通信する構成

### プライベートサブネット
| IPv4/CIDR | ターゲット|
|--|--|
|10.0.0.0/16|local|


- 10.0.0.0 ~ 10.0.255.254までは同VPCでローカル通信
- インターネットに出れない


## ELB
| 名前 | 概要 |VPC|ターゲットグループ |ポート|
|--|--|--|--|--|
|zenn-test-alb-backend|バックエンドのELB|zenn-test-vpc|zenn-clone-alb-backend-tg |80,443 | |
|zenn-test-alb-backend|フロントエンドのELB|zenn-test-vpc |zenn-clone-alb-backend-tg | 80,443|


## ECR
| リポジトリ名 |概要|
|--|--|
| zenn-test-next | nextコンテナのリポジトリ |
| zenn-test-rails | railsコンテナのリポジトリ |
| zenn-test-nginx | nginxコンテナのリポジトリ |



## ECS

### クラスタ
| 項目 |値|
|--|--|
| 名前 | zenn-test-cluster |


### サービス
| 名前 |概要|VPC|コンテナ|
|--|--|--|--|
| zenn-test-backend-service|バックエンドのコンテナ|zenn-test-vpc|nginx,rails|
| zenn-test-frontend-service|フロントエンドのコンテナ|zenn-test-vpc|next|


### タスク

### タスク定義
|タスク定義名 |起動タイプ|概要|アーキテクチャ|タスクロール実行ロール|
|--|--|--|--|--|
|zenn-test-task-definition-backend|AWS Fargate|バックエンド用のタスク定義|Linux/x86_64|ecsTaskExecutionRole
|zenn-test-task-definition-frontend |AWS Fargate| フロントエンド用のタスク定義|Linux/x86_64|ecsTaskExecutionRole


### コンテナ一覧
 名前 |概要|VPC|ポートマッピング|
|--|--|--|--
|nginx|railsコンテナとソケット通信|zenn-test-vpc|80:80
|rails|APIサーバのコンテナ | zenn-test-vpc|3000:3000
|next|フロント側のコンテナ | zenn-test-vpc|80:80