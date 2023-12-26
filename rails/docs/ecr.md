## ECRにpushする手順
1. 認証トークンを取得し、レジストリに対して Docker クライアントを認証
``` bash
aws ecr get-login-password --region ap-northeast-1 --proofile プロファイル名 | docker login --username AWS --password-stdin url
```

