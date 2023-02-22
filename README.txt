To add root AWS user to kuberntes cluster

command: kubectl edit configmap aws-auth -n kube-system

Add the following lines
mapUsers: |
  - userarn: arn:aws:iam::[account_id]:root
    groups:
    - system:masters