/* 
  ECSをIAMロールを作成する
*/
# 実行ロールとタスクロールを作成する
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"
  assume_role_policy = jsonencode(({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  }))
}
# SESのフルアクセス権限をアタッチする
resource "aws_iam_policy_attachment" "ses_full_access" {
  name = "${var.project_name}-ses-full-access"
  # ECSタスク実行ロールにSESのフルアクセス権限をアタッチする  
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

# ECSタスク実行ロールのポリシーをアタッチする
resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy" {
  name = "${var.project_name}-ecs-task-execution-role-access"
  # ECSタスク実行ロールにECSタスク実行ロールポリシーをアタッチする
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECSタスク実行ロールにS3のフルアクセス権限をアタッチする
resource "aws_iam_policy_attachment" "s3_full_access" {
  name = "${var.project_name}-s3-full-access"
  # ECSタスク実行ロールにS3のフルアクセス権限をアタッチする
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


# ECSタスク実行ロールにSession Managerの権限をアタッチする

# Session Manager用のIAMポリシーを作成する
data "aws_iam_policy_document" "session_manager_policy" {
  statement {
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = ["*"]
  }
}

/* 
  Session Manager用のIAMポリシーを作成する
  上記で作成したポリシーをアタッチする
 */
resource "aws_iam_policy" "session_manager_policy" {
  name        = "${var.project_name}-session-manager-policy"
  description = "Session Manager Policy"
  policy      = data.aws_iam_policy_document.session_manager_policy.json
}

/* 
  ECSタスク実行ロールにSession Managerのポリシーをアタッチする
 */
resource "aws_iam_role_policy_attachment" "session_manager_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}
