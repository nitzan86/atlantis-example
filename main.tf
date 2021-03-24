provider "aws" {
  region  = "us-east-1"
  
}

resource "null_resource" "example" {
}

resource "aws_sqs_queue" "default" {
  name = "atlantis-example-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds = 345600
  delay_seconds = 0
  receive_wait_time_seconds = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 5
  })
  fifo_queue = false
  tags = {
    "everquote:aws:account" = "distribution-platform"
    "everquote:category"    = "terraform"
    "everquote:env"         = "staging"
    "everquote:heritage"    = "terraform"
    "everquote:owner"       = "distribution-platform-engineering"
    "everquote:service"     = "example-queue"
  }
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name = "atlantis-example-queue-dlq"
  visibility_timeout_seconds = "30"
  message_retention_seconds = "345600"

  tags = {
    "everquote:aws:account" = "distribution-platform"
    "everquote:category"    = "terraform"
    "everquote:env"         = "staging"
    "everquote:heritage"    = "terraform"
    "everquote:owner"       = "distribution-platform-engineering"
    "everquote:service"     = "example-queue"
  }
}