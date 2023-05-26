# AWS ECS task need two types of roles
# 1. Task Execution-This will be used by containers inside task
# 2. Task- This is by task itself
resource "aws_iam_role" "api_role_task_execution" {
    name = "${local.tags.Name}-task-execution"
    assume_role_policy = data.aws_iam_policy_document.ecs-trust.json
    tags = local.tags

}

# This one is mandatory to pull images from ecr
resource "aws_iam_role_policy_attachment" "ecr_pull" {
  role       = aws_iam_role.api_role_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "api_role-task" {
    name = "${local.tags.Name}-task"
    assume_role_policy = data.aws_iam_policy_document.ecs-trust.json
    tags = local.tags

}