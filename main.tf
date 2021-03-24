resource "null_resource" "example" {
}

resource "aws_sqs_queue" "default" {
  name = "atlantis-example-queue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds = var.message_retention_seconds
  delay_seconds = var.delay_seconds
  receive_wait_time_seconds = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = var.max_attempts
  })
  fifo_queue = var.sqs_fifo_queue
  tags = {
    "everquote:aws:account" = "distribution-platform"
    "everquote:category"    = "terraform"
    "everquote:env"         = "staging"
    "everquote:heritage"    = "terraform"
    "everquote:owner"       = "distribution-platform-engineering"
    "everquote:service"     = "example-queue"
  }
}